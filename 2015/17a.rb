require './17_input'

def input_to_array
  INPUT.split("\n").map(&:to_i)
end

require 'set'
def match_permutations(goal)
  matches = Set.new
  input_to_array.permutation.each do |order|
    sum = 0
    order.each_with_index do |num, index|
      sum += num
      break if sum > goal
      matches << order[0..index] if sum == goal
    end
  end
  puts matches.size
end

match_permutations(150)
