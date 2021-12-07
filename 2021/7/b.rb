class CrabSubmarine
  def initialize
    @input = File.readlines('input').flat_map { |n| n.strip.split(',').map(&:to_i) }.sort
  end

  def lowest_fuel_required
    lowest_position_cost = nil

    (0..list.last).each do |num|
      costs = @input.map { |position| cost_at_distance((position - num).abs) }
      cur_cost = costs.sum

      if lowest_position_cost.nil? || cur_cost < lowest_position_cost
        lowest_position_cost = cur_cost
      end
    end

    lowest_position_cost
  end

  private

  def cost_at_distance(distance)
    (0..distance).to_a.sum
  end
end

puts CrabSubmarine.new.lowest_fuel_required
