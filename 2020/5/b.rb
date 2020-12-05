class AirplaneSeatFinder
  def initialize
    @input = File.readlines('input').map(&:strip)
  end

  def find_seat_id
    seat_ids = input.map { |seat_str| seat_id(seat_str) }.sort
    seat_ids.each_with_index { |num, i| return num - 1 if i != 0 && seat_ids[i - 1] != num - 1 }
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

puts AirplaneSeatFinder.new.find_seat_id
