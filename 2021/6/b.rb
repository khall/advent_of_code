class ExponentialGrowth
  def initialize
    input = File.readlines('input').flat_map { |n| n.strip.split(',').map(&:to_i) }.sort
    @input = [input.count(0),
              input.count(1),
              input.count(2),
              input.count(3),
              input.count(4),
              input.count(5),
              input.count(6),
              input.count(7),
              input.count(8)]
  end

  def simulate
    256.times do |day|
      puts "#{day} - #{@input}"

      new_eights = @input[0]
      8.times do |i|
        @input[i] = @input[i + 1]
      end

      @input[6] += new_eights
      @input[8] = new_eights
    end

    @input.sum
  end
end

puts ExponentialGrowth.new.simulate
