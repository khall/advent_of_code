puts File.open('12_input.json').read.scan(/-?\d+/).inject(0) { |sum, num| sum += num.to_i }
