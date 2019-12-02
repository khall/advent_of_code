class Fuel
  attr_reader :input

  def initialize
    @input = File.readlines('input').map { |n| n.strip.to_i }
  end

  def total_required
    input.sum { |n| individual_required n }
  end

  private

  def individual_required(num)
    (num / 3.0).floor - 2
  end
end

puts Fuel.new.total_required
