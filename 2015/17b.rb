container_sizes = File.readlines('17_input').map(&:to_i)
count = 0
container_sizes.size.times do |i|
  count += container_sizes.combination(i).to_a.select { |c| c.sum == 150 }.size
  break if count != 0
end
puts count
