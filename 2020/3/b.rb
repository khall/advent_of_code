class SkiingPath
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
    @height = input.size
    @width = input.first.size
  end

  def num_trees_hit
    slopes = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]
    count = [0] * slopes.size

    slopes.each_with_index do |(run, rise), i|
      x = 0
      y = 0
      while y < height
        count[i] += 1 if input[y][x % width] == '#'
        x += run
        y += rise
      end
    end

    count.inject(:*)
  end

  private

  attr_reader :height, :input, :width
end

puts SkiingPath.new.num_trees_hit
