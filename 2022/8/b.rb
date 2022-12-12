require 'byebug'
class Forest
  def initialize
    @input = File.readlines('input').map { |line| line.strip.chars }
  end

  def highest_scenic_score
    forest_height = @input.size
    forest_width = @input.first.size
    puts "forest_height: #{forest_height}, forest_width: #{forest_width}"
    max_scenic_score = 0

    @input.each_with_index do |row, y|
      next if y == 0 || y == (forest_height - 1)

      row.each_with_index do |_tree_height, x|
        next if x.zero? || x == (forest_width - 1)

        score = scenic_score(x, y)
        max_scenic_score = score if score > max_scenic_score
      end
    end

    # puts visible_tree_array.map { |row| row.join(' ') }
    max_scenic_score
  end

  private

  def scenic_score(x, y)
    house_height = @input[y][x].to_i

    left_distance = 0
    # running_height = 0
    (x - 1).downto(0) do |left|
      left_distance += 1
      # break if left == 0 || @input[y][left].to_i < running_height || @input[y][left].to_i >= house_height
      break if left == 0 || @input[y][left].to_i >= house_height

      # running_height = @input[y][left].to_i
    end

    up_distance = 0
    # running_height = 0
    (y - 1).downto(0) do |up|
      up_distance += 1
      # break if up == 0 || @input[up][x].to_i < running_height || @input[up][x].to_i >= house_height
      break if up == 0 || @input[up][x].to_i >= house_height

      # running_height = @input[up][x].to_i
    end

    right_distance = 0
    # running_height = 0
    right_limit = @input.first.size - 1
    (x + 1).upto(right_limit) do |right|
      right_distance += 1
      # break if right == right_limit || @input[y][right].to_i < running_height || @input[y][right].to_i >= house_height
      break if right == right_limit || @input[y][right].to_i >= house_height

      # running_height = @input[y][right].to_i
    end

    down_distance = 0
    # running_height = 0
    up_limit = @input.size - 1
    (y + 1).upto(up_limit) do |down|
      down_distance += 1
      # break if down == up_limit || @input[down][x].to_i < running_height || @input[down][x].to_i >= house_height
      break if down == up_limit || @input[down][x].to_i >= house_height

      # running_height = @input[down][x].to_i
    end

    puts "x: #{x}, y: #{y}, house_height: #{house_height}, left_distance: #{left_distance}, up_distance: #{up_distance}, right_distance: #{right_distance}, down_distance: #{down_distance}"
    left_distance * up_distance * right_distance * down_distance
  end
end

puts Forest.new.highest_scenic_score
