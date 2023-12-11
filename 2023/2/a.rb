class CubeBagGame
  MAX_RED = 12
  MAX_GREEN = 13
  MAX_BLUE = 14

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

  def sum_possible_games
    @input.flat_map.with_index do |games, i|
      possible = games.all? do |game|
        game[:red].to_i <= MAX_RED && game[:green].to_i <= MAX_GREEN && game[:blue].to_i <= MAX_BLUE
      end
      possible ? i + 1 : 0
    end.sum
  end
end

puts CubeBagGame.new.sum_possible_games
