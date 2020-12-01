class SummedGroups
  def initialize(group_size, sum_target)
    @group_size = group_size
    @input = File.readlines('input').map { |n| n.strip.to_i }
    @sum_target = sum_target
  end

  def find
    input.combination(group_size).detect { |combination| combination.sum == sum_target }
  end

  private

  attr_reader :group_size, :input, :sum_target
end

puts SummedGroups.new(3, 2020).find.inject(:*)
