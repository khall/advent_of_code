require 'byebug'

class AnimatedLights
  attr_accessor :lights, :new_lights, :size

  def initialize(size)
    @size = size
    @lights = File.readlines('18_input').map { |row| row.chomp.split('') }
  end

  def animate
    100.times do
      accumulator = []
      lights.each_with_index do |row, y|
        row.each_with_index do |light, x|
          accumulator << new_light_state(x, y, light)
        end
      end
      @lights = accumulator.each_slice(size).to_a
    end
  end

  def new_light_state(x, y, light)
    nearby_count = num_nearby_enabled_lights(x, y)
    if [2, 3].include?(nearby_count) && light == '#'
      '#'
    elsif nearby_count == 3 && light == '.'
      '#'
    else
      '.'
    end
  end

  def num_nearby_enabled_lights(x, y)
    last = size - 1
    [y == 0 || x == 0 ? '.' : lights[y - 1][x - 1],
     y == 0 ? '.' : lights[y - 1][x],
     y == 0 || x == last ? '.' : lights[y - 1][x + 1],
     x == 0 ? '.' : lights[y][x - 1],
     x == last ? '.' : lights[y][x + 1],
     y == last || x == 0 ? '.' : lights[y + 1][x - 1],
     y == last ? '.' : lights[y + 1][x],
     y == last || x == last ? '.' : lights[y + 1][x + 1]].count('#')
  end
end

animated_lights = AnimatedLights.new(100)
animated_lights.animate
puts animated_lights.lights.flatten.count('#')
