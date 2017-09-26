require './6_input'

class LightGrid
  attr_accessor :grid

  def initialize
    @grid = Array.new(1000) { Array.new(1000, 0) }
  end

  def turn_on(from, to)
    walk_range(from, to, :increase_column)
  end

  def toggle(from, to)
    walk_range(from, to, :increase_column_more)
  end

  def turn_off(from, to)
    walk_range(from, to, :decrease_column)
  end

  def light_brightness
    num = 0
    grid.each do |col|
      num += col.inject { |sum, n| sum + n }
    end
    num
  end

  private

  def walk_range(from, to, command)
    (from[0]..to[0]).each do |column|
      params = build_params(column, from, to)
      send(command, *params)
    end
  end

  def build_params(column, from, to)
    [column, from[1], to[1]]
  end

  def increase_column(col, from, to)
    (from..to).each do |row|
      grid[col][row] += 1
    end
  end

  def increase_column_more(col, from, to)
    (from..to).each do |row|
      grid[col][row] += 2
    end
  end

  def decrease_column(col, from, to)
    (from..to).each do |row|
      grid[col][row] -= 1 if grid[col][row] > 0
    end
  end
end

class InstructionParser
  def self.run
    grid = LightGrid.new
    INPUT.split("\n").each do |command|
      command.match(/(turn on|turn off|toggle) (\d+,\d+) through (\d+,\d+)/)
      command = Regexp.last_match(1).tr(' ', '_')
      lower_left = Regexp.last_match(2).split(',').map(&:to_i)
      upper_right = Regexp.last_match(3).split(',').map(&:to_i)
      grid.send(command, lower_left, upper_right)
    end
    puts grid.light_brightness
  end
end

InstructionParser.run
