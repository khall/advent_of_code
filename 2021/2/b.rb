class SubmarinePosition
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def final_position_product
    horizontal_position = 0
    vertical_position = 0
    aim = 0

    @input.each do |instruction|
      direction, amount = instruction.split(' ')
      case direction
      when 'forward'
        horizontal_position += amount.to_i
        vertical_position += aim * amount.to_i
      when 'down'
        aim += amount.to_i
      when 'up'
        aim -= amount.to_i
      end
    end

    horizontal_position * vertical_position
  end
end

puts SubmarinePosition.new.final_position_product
