require './1_input'

def final_floor
  INPUT.count('(') - INPUT.count(')')
end

puts final_floor
