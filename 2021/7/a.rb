class CrabSubmarine
  def initialize
    @input = File.readlines('input').flat_map { |n| n.strip.split(',').map(&:to_i) }.sort
  end

  def lowest_fuel_required
    goal = median(@input)
    fuel = 0
    @input.each do |num|
      fuel += (goal - num).abs
    end
    fuel
  end

  private

  def median(list)
    if list.size.odd?
      list[list.size / 2]
    else
      (list[list.size / 2] + list[list.size / 2 - 1]) / 2
    end
  end
end

puts CrabSubmarine.new.lowest_fuel_required
