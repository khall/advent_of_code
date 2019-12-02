class Fuel
  attr_reader :input

  def initialize
    @input = File.readlines('input').map { |n| n.strip.to_i }
  end

  def total_required
    @non_fuel_requirement ||= input.sum do |n|
      non_fuel = individual_requirement(n)
      non_fuel + fuel_required_for_fuel(non_fuel)
    end
  end

  private

  def fuel_required_for_fuel(current_fuel, total_fuel_fuel = 0)
    additional_fuel = individual_requirement(current_fuel)
    return total_fuel_fuel if additional_fuel <= 0

    fuel_required_for_fuel(additional_fuel, total_fuel_fuel + additional_fuel)
  end

  def individual_requirement(num)
    (num / 3.0).floor - 2
  end
end

puts Fuel.new.total_required
