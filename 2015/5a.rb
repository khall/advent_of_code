require './5_input'

def is_nice?(str)
  three_vowels?(str) && doubled_letter?(str) && !contains_bad_strings?(str)
end

def three_vowels?(str)
  str.count('aeiou') > 2
end

def doubled_letter?(str)
  str.match(/([a-z])\1/)
end

def contains_bad_strings?(str)
  bad_strings = %w(ab cd pq xy)
  bad_strings.each do |bad_string|
    return true if str.include?(bad_string)
  end
  false
end

def count_nice_strings
  INPUT.select { |str| is_nice?(str) }.size
end

puts count_nice_strings
