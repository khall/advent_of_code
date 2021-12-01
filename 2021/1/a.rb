class DepthFinder
  def initialize
    @input = File.readlines('input').map { |n| n.strip.to_i }
  end

  def num_increasing_depths
    count = -1
    last_depth = 0
    @input.each do |depth|
      count += 1 if depth > last_depth
      last_depth = depth
    end
    count
  end
end

puts DepthFinder.new.num_increasing_depths
