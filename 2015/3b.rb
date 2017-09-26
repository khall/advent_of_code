require './3_input'

class Grid
  attr_accessor :visited, :santa_position, :robo_santa_position

  def initialize
    @visited = [[0, 0]]
    @santa_position = { x: 0, y: 0 }
    @robo_santa_position = { x: 0, y: 0 }
  end

  def move(who, x, y)
    position = who == :santa ? santa_position : robo_santa_position
    position[:x] += x
    position[:y] += y
    save_visited(position)
  end

  def save_visited(position)
    visited << [position[:x], position[:y]]
  end
end

class DirectionElf
  attr_accessor :directions, :grid

  def initialize
    @directions = INPUT
    @grid = Grid.new
  end

  def move_santas
    who = :santa
    directions.each_char do |direction|
      grid.move(who, *char_to_array(direction))
      who = who == :santa ? :robo_santa : :santa
    end
  end

  private

  def char_to_array(letter)
    { 'v' => [0, -1], '>' => [1, 0], '<' => [-1, 0], '^' => [0, 1] }[letter]
  end
end

elf = DirectionElf.new
elf.move_santas
puts elf.grid.visited.uniq.size
