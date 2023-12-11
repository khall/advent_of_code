require 'byebug'

class CubeBagGame
  def initialize
    @input = File.readlines('input').map do |line|
      line.strip.split(': ').last.split(';').flat_map do |game|
        red = game.match(/(\d+) red/)
        green = game.match(/(\d+) green/)
        blue = game.match(/(\d+) blue/)
        { red: red && red[1].to_i, green: green && green[1].to_i, blue: blue && blue[1].to_i }.compact
      end
    end
  end

  def sum_minimum_cube_powers
    @input.flat_map.with_index do |games, i|
      min_red = 0
      min_green = 0
      min_blue = 0
      games.each do |game|
        min_red = game[:red].to_i if min_red < game[:red].to_i
        min_green = game[:green].to_i if min_green < game[:green].to_i
        min_blue = game[:blue].to_i if min_blue < game[:blue].to_i
      end
      min_red * min_green * min_blue
    end.sum
  end
end

puts CubeBagGame.new.sum_minimum_cube_powers
