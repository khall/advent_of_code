require 'byebug'

class Grid
  attr_reader :grid, :input, :intersection_values, :origin
  GRID_SIZE = 25_000

  Point = Struct.new(:x, :y)

  def initialize
    @origin = Point.new(GRID_SIZE / 2, GRID_SIZE / 2)
    @intersection_values = []
    load_input
    load_grid
    draw_lines
  end

  def fewest_steps_intersection
    intersection_values.min
  end

  private

  def load_input
    @input = File.readlines('input')
  end

  def load_grid
    @grid = Array.new(GRID_SIZE) { Array.new(GRID_SIZE, 0) }
  end

  def draw_lines
    draw_first_line
    draw_second_line
  end

  def draw_first_line
    steps = 0
    position = origin.dup
    input.first.split(',').each do |instruction|
      length = instruction[1..-1].to_i
      case instruction[0]
      when 'U'
        length.times do
          grid[position.x][position.y] = steps
          steps += 1
          position.y += 1
        end
      when 'D'
        length.times do
          grid[position.x][position.y] = steps
          steps += 1
          position.y -= 1
        end
      when 'R'
        length.times do
          grid[position.x][position.y] = steps
          steps += 1
          position.x += 1
        end
      when 'L'
        length.times do
          grid[position.x][position.y] = steps
          steps += 1
          position.x -= 1
        end
      else
        raise 'bad input'
      end
    end
  end

  def draw_second_line
    steps = 0
    position = origin.dup
    input.last.split(',').each do |instruction|
      length = instruction[1..-1].to_i
      case instruction[0]
      when 'U'
        length.times do
          append_intersection(grid[position.x][position.y], steps)
          steps += 1
          position.y += 1
        end
      when 'D'
        length.times do
          append_intersection(grid[position.x][position.y], steps)
          steps += 1
          position.y -= 1
        end
      when 'R'
        length.times do
          append_intersection(grid[position.x][position.y], steps)
          steps += 1
          position.x += 1
        end
      when 'L'
        length.times do
          append_intersection(grid[position.x][position.y], steps)
          steps += 1
          position.x -= 1
        end
      else
        raise 'bad input'
      end
    end
  end

  def append_intersection(position_value, steps)
    intersection_values << (position_value + steps) if position_value > 0
  end
end

puts Grid.new.fewest_steps_intersection
