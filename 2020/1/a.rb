class SummedPairs
  def initialize(sum_target)
    @input = File.readlines('input').map { |n| n.strip.to_i }
    @sum_target = sum_target
  end

  def find
    input.combination(2).detect { |a, b| a + b == sum_target }
  end

  private

  attr_reader :input, :sum_target
end

puts SummedPairs.new(2020).find.inject(:*)
