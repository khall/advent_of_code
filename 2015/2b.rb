require './2_input'

def ribbon_length(dimension_str)
  dimensions = split_to_ints(dimension_str)
  volume = dimensions.inject(1) { |prod, n| prod * n }
  short_side = dimensions.min(2).inject{ |sum, n| sum + n } * 2
  volume + short_side
end

def split_to_ints(dimension_str)
  dimension_str.split('x').map(&:to_i)
end

def sum_all_ribbon
  INPUT.split(' ').map { |dimension| ribbon_length(dimension) }.inject{ |sum, n| sum + n }
end

puts sum_all_ribbon
