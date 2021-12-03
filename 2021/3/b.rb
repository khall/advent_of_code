class BinaryDiagnostic
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def gamma_epsilon_product
    original_input = @input.dup

    reduce_via { |zero_counter, half_input_len| zero_counter <= half_input_len ? '1' : '0' }
    oxygen_generator_rating = @input[0]
    @input = original_input

    reduce_via { |zero_counter, half_input_len| zero_counter <= half_input_len ? '0' : '1' }
    co2_scrubber_rating = @input[0]

    oxygen_generator_rating.to_i(2) * co2_scrubber_rating.to_i(2)
  end

  private

  def reduce_via
    @input.first.size.times do |i|
      break if @input.size == 1

      zero_counter = count_zeros_at_position(i)
      half_input_len = @input.size / 2.0

      selected_value = yield(zero_counter, half_input_len)
      @input.select! { |row| row[i] == selected_value }
    end
  end

  def count_zeros_at_position(position)
    @input.select { |num| num[position] == '0' }.count
  end
end

puts BinaryDiagnostic.new.gamma_epsilon_product
