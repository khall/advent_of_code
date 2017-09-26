require './5_input'

def is_nice?(str)
  two_pairs?(str) && pair_with_letter_between?(str)
end

def two_pairs?(str)
  str.match(/([a-z][a-z]).*\1/)
end

def pair_with_letter_between?(str)
  str.match(/([a-z]).\1/)
end

def count_nice_strings
  INPUT.select { |str| is_nice?(str) }.size
end

puts count_nice_strings
