require './1_input'

def basement_index
  i = 0
  floor = 0
  INPUT.each_char do |c|
    break if floor < 0
    if c == '('
      floor += 1
    else
      floor -= 1
    end
    i += 1
  end
  i
end

puts basement_index
