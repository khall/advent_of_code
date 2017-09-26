require './6_input'

class LightGrid
  attr_accessor :grid

  def initialize
    @grid = Array.new(1000) { Array.new(1000, 0) }
  end

  def turn_on(from, to)
    walk_range(from, to, :on)
  end

  def toggle(from, to)
    walk_range(from, to, :toggle)
  end

  def turn_off(from, to)
    walk_range(from, to, :off)
  end

  def number_lights_on
    num = 0
    grid.each do |col|
      num += col.count(1)
    end
    num
  end

  private

  def walk_range(from, to, command)
    method = { on: 'turn_column', off: 'turn_column', toggle: 'toggle_column' }[command]
    (from[0]..to[0]).each do |column|
      params = build_params(column, command, from, to)
      send(method, *params)
    end
  end

  def build_params(column, command, from, to)
    params = [column, from[1], to[1]]
    params = [command] + params if [:on, :off].include?(command)
    params
  end

  def turn_column(command, col, from, to)
    length = to - from + 1
    grid[col][from, length] = Array.new(length, (command == :on ? 1 : 0))
  end

  def toggle_column(col, from, to)
    (from..to).each do |row|
      grid[col][row] ^= 1
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
    puts grid.number_lights_on
  end
end

InstructionParser.run
