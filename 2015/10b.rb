INPUT = '1113222113'

def run(num)
  value = INPUT
  num.times do |n|
    value = process(value)
  end
  puts value.length
end

def process(value)
  new_value = []
  value.scan(/((\d)\2*)/) { |n, digits| new_value << "#{n.length}#{digits}" }
  new_value.join
end

run(50)
