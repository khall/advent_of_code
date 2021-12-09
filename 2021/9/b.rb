class HeightMap
  def initialize
    @input = File.readlines('input').map { |n| [9] + n.strip.split('').map(&:to_i) + [9] }
    @width = @input[0].size
    @input = [[9] * @width] + @input + [[9] * @width]
  end

  def three_largest_basins_product
    lowest_point_coordinates.map do |x, y|
      basin_size_for_coordinate(x, y)
    end.sort.last(3).inject(&:*)
  end

  private

  def basin_size_for_coordinate(x, y)
    points_in_basin(x, y).compact.uniq.size
  end

  def points_in_basin(x, y, basin_points = [])
    return [] if @input[y][x] == 9 || basin_points.include?([x, y])
    basin_points << [x, y]

    [[x, y]] +
      points_in_basin(x - 1, y, basin_points) +
      points_in_basin(x + 1, y, basin_points) +
      points_in_basin(x, y - 1, basin_points) +
      points_in_basin(x, y + 1, basin_points)
  end

  def lowest_point_coordinates
    lowest_points = []
    height = @input.size

    (1..(height - 1)).each do |i|
      (1..(@width - 1)).each do |j|
        cur_height = @input[i][j]
        if cur_height < @input[i][j - 1] &&
          cur_height < @input[i][j + 1] &&
          cur_height < @input[i - 1][j] &&
          cur_height < @input[i + 1][j]
          lowest_points << [j, i]
        end
      end
    end

    lowest_points
  end
end

puts HeightMap.new.three_largest_basins_product
