class HeightMap
  def initialize
    @input = File.readlines('input').map { |n| [9] + n.strip.split('').map(&:to_i) + [9] }
    @width = @input[0].size
    @input = [[9] * @width] + @input + [[9] * @width]
  end

  def risk_level_sum
    lowest_points = []
    height = @input.size

    (1..(height - 1)).each do |i|
      (1..(@width - 1)).each do |j|
        cur_height = @input[i][j]
        if cur_height < @input[i][j - 1] &&
           cur_height < @input[i][j + 1] &&
           cur_height < @input[i - 1][j] &&
           cur_height < @input[i + 1][j]
          lowest_points << cur_height + 1
        end
      end
    end

    lowest_points.sum
  end
end

puts HeightMap.new.risk_level_sum
