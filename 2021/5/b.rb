require 'byebug'

class OverlappingLines
  def initialize
    @input = File.readlines('input').map { |n| n.strip.split(' -> ').map { |coordinates| coordinates.split(',').map(&:to_i) } }
    @grid = Array.new(1000) { Array.new(1000, 0) }
  end

  def overlapping_points
    @input.each do |coordinate1, coordinate2|
      increment_range(coordinate1, coordinate2)
    end

    @grid.flatten.select { |point| point > 1 }.size
  end

  private

  def increment_range(coordinate1, coordinate2)
    if coordinate1[0] == coordinate2[0]
      increment_y_range(coordinate1[0], *[coordinate1[1], coordinate2[1]].sort)
    elsif coordinate1[1] == coordinate2[1]
      increment_x_range(coordinate1[1], *[coordinate1[0], coordinate2[0]].sort)
    else
      increment_diagonal(coordinate1[0], coordinate2[0], coordinate1[1], coordinate2[1])
    end
  end

  def increment_x_range(y, x_start, x_end)
    (x_start..x_end).each do |x|
      @grid[y][x] += 1
    end
  end

  def increment_y_range(x, y_start, y_end)
    (y_start..y_end).each do |y|
      @grid[y][x] += 1
    end
  end

  def increment_diagonal(x_start, x_end, y_start, y_end)
    x_func = x_start < x_end ? :upto : :downto
    y_func = y_start < y_end ? :upto : :downto
    x_list = x_start.public_send(x_func, x_end).to_a
    y_list = y_start.public_send(y_func, y_end).to_a

    x_list.each_with_index do |x, i|
      @grid[y_list[i]][x] += 1
    end
  end
end

puts OverlappingLines.new.overlapping_points
