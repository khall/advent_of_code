INPUT = '1113222113'

def run(num)
  value = INPUT
  num.times do |n|
    value = process(value)
  end
  puts value.length
end

def process(value)
  new_value = ''
  while value.length > 0 do
    matched_str = value.match(/^(\d)\1*/)[0]
    new_value += "#{matched_str.length}#{matched_str[0]}"
    value = value[matched_str.length..-1]
  end
  new_value
end

run(40)
