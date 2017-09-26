require './3_input'

class Grid
  attr_accessor :visited, :position

  def initialize
    @visited = [[0, 0]]
    @position = { x: 0, y: 0 }
  end

  def move(x, y)
    position[:x] += x
    position[:y] += y
    save_visited
  end

  def save_visited
    visited << [position[:x], position[:y]]
  end
end

class DirectionElf
  attr_accessor :directions, :grid

  def initialize
    @directions = INPUT
    @grid = Grid.new
  end

  def move_santa
    directions.each_char do |direction|
      grid.move(*char_to_array(direction))
    end
  end

  private

  def char_to_array(letter)
    { 'v' => [0, -1], '>' => [1, 0], '<' => [-1, 0], '^' => [0, 1] }[letter]
  end
end

elf = DirectionElf.new
elf.move_santa
puts elf.grid.visited.uniq.size
