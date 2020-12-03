class SkiingPath
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
    @height = input.size
    @width = input.first.size
  end

  def num_trees_hit
    x = 0
    y = 0
    count = 0

    while y < height
      count += 1 if input[y][x % width] == '#'
      x += 3
      y += 1
    end
    count
  end

  private

  attr_reader :height, :input, :width
end

puts SkiingPath.new.num_trees_hit
