class Grid
  attr_reader :grid, :input, :intersections, :origin
  GRID_SIZE = 25_000

  Point = Struct.new(:x, :y)

  def initialize
    @origin = Point.new(GRID_SIZE / 2, GRID_SIZE / 2)
    @intersections = []
    load_input
    load_grid
    draw_lines
  end

  def nearest_intersection_manhattan_distance
    (intersections - [Point.new(origin.x, origin.y)]).map do |point|
      distance_from_origin(point)
    end.min
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
    position = origin.dup
    input.first.split(',').each do |instruction|
      length = instruction[1..-1].to_i
      case instruction[0]
      when 'U'
        length.times do
          grid[position.x][position.y] += 1
          position.y += 1
        end
      when 'D'
        length.times do
          grid[position.x][position.y] += 1
          position.y -= 1
        end
      when 'R'
        length.times do
          grid[position.x][position.y] += 1
          position.x += 1
        end
      when 'L'
        length.times do
          grid[position.x][position.y] += 1
          position.x -= 1
        end
      else
        raise 'bad input'
      end
    end
  end

  def draw_second_line
    position = origin.dup
    input.last.split(',').each do |instruction|
      length = instruction[1..-1].to_i
      case instruction[0]
      when 'U'
        length.times do
          append_intersection(position)
          grid[position.x][position.y] = 'x' if grid[position.x][position.y] == 0
          position.y += 1
        end
      when 'D'
        length.times do
          append_intersection(position)
          grid[position.x][position.y] = 'x' if grid[position.x][position.y] == 0
          position.y -= 1
        end
      when 'R'
        length.times do
          append_intersection(position)
          grid[position.x][position.y] = 'x' if grid[position.x][position.y] == 0
          position.x += 1
        end
      when 'L'
        length.times do
          append_intersection(position)
          grid[position.x][position.y] = 'x' if grid[position.x][position.y] == 0
          position.x -= 1
        end
      else
        raise 'bad input'
      end
    end
  end

  def append_intersection(position)
    intersections << position.dup if grid[position.x][position.y] > 0
  end

  def distance_from_origin(point)
    (origin.x - point.x).abs + (origin.y - point.y).abs
  end
end

puts Grid.new.nearest_intersection_manhattan_distance
