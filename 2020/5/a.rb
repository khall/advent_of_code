class AirplaneSeatFinder
  def initialize
    @input = File.readlines('input').map(&:strip)
  end

  def highest_seat_id
    input.map { |seat_str| seat_id(seat_str) }.max
  end

  private

  attr_reader :input

  def seat_id(str)
    id(str[0..6]) * 8 + id(str[7..9])
  end

  def id(str)
    min = 0
    max = 2 ** str.size - 1

    str.each_char.with_index do |char, i|
      if lower_chars.include?(char)
        return min if str.size - 1 == i
        max -= (max - min) / 2 + 1
      else
        return max if str.size - 1 == i
        min += (max - min) / 2 + 1
      end
    end
  end

  def lower_chars
    %w(F L)
  end
end

puts AirplaneSeatFinder.new.highest_seat_id
