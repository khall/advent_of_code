require 'byebug'
require 'JSON'

def eliminate_red_hashes(data)
  return if data.is_a?(String) || data.is_a?(Fixnum)
  if data.is_a?(Hash) && (data.keys.include?('red') || data.values.include?('red'))
    sum = data.to_s.scan(/-?\d+/).inject(0) { |sum, num| sum += num.to_i }
    add_to_subtractor(sum)
    return
  end
  data.each do |datum|
    eliminate_red_hashes(datum)
  end
end

@subtractor = 0
def add_to_subtractor(sum)
  @subtractor += sum
end

file_str = File.open('12_input.json').read
eliminate_red_hashes(JSON.parse file_str)

puts file_str.scan(/-?\d+/).inject(0) { |sum, num| sum += num.to_i } - @subtractor
