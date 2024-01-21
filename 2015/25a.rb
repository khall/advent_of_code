def next_code(val)
  (val * 252533) % 33554393
end

def generate_codes
  codes = Array.new(6000) { Array.new }

  current_value = 20151125
  codes[1][1] = current_value
  row = 2
  col = 1

  loop do
    return next_code(current_value) if row == 2947 && col == 3029

    codes[row][col] = next_code(current_value)
    current_value = codes[row][col]
    row -= 1
    col += 1

    if row <= 0
      row = col
      col = 1
    end
  end
end

puts generate_codes
