require './2_input'

def paper_size(dimension_str)
  x, y, z = split_to_ints(dimension_str)
  sides = []
  sides << 2 * x * y
  sides << 2 * x * z
  sides << 2 * z * y
  sides.inject{ |sum, n| sum + n } + (sides.min / 2)
end

def split_to_ints(dimension_str)
  dimension_str.split('x').map(&:to_i)
end

def sum_all_paper
  INPUT.split(' ').map { |dimension| paper_size(dimension) }.inject{ |sum, n| sum + n }
end

puts sum_all_paper
