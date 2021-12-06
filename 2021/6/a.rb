
class ExponentialGrowth
  def initialize
    @input = File.readlines('input').flat_map { |n| n.strip.split(',').map(&:to_i) }
  end

  def simulate
    80.times do
      stop_index = @input.size
      @input.each_with_index do |_fish, i|
        break if i == stop_index

        if @input[i] == 0
          @input[i] = 6
          @input << 8
        else
          @input[i] -= 1
        end
      end
    end

    @input.size
  end
end

puts ExponentialGrowth.new.simulate
