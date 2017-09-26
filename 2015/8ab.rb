def read_and_calculate_input
  file = File.open('./8_input.rb')
  code = 0
  bytes = 0
  encoded = 0
  file.each_line do |line|
    code += line.length - 1 # minus 1 for the newline
    bytes += eval("#{line}").length
    encoded += line.length - 1 + line.count('"') + line.count('\\') + 2 # minus 1 for the newline, plus 2 for the quotes
  end
  puts "a: #{code - bytes}"
  puts "b: #{encoded - code}"
end

read_and_calculate_input
