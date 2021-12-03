class BinaryDiagnostic
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def gamma_epsilon_product
    input_len = @input.first.size
    zero_counter = Array.new(input_len) { 0 }

    @input.each do |num|
      num.split('').each_with_index do |digit, i|
        zero_counter[i] += 1 if digit == '0'
      end
    end

    gamma = ''
    half_input_len = @input.size / 2.0
    @input.first.size.times do |i|
      gamma << ((zero_counter[i] > half_input_len) ? '0' : '1')
    end
    epsilon = gamma.tr('01', '10')

    gamma.to_i(2) * epsilon.to_i(2)
  end
end

puts BinaryDiagnostic.new.gamma_epsilon_product
