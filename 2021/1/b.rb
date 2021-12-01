class DepthFinder
  def initialize
    @input = File.readlines('input').map { |n| n.strip.to_i }
  end

  def num_increasing_group_depths
    count = -1
    last_group_sum = 0
    last_input_index = @input.size - 1

    (2..last_input_index).each do |depth_index|
      group_sum = @input[(depth_index - 2)..depth_index].sum
      count += 1 if group_sum > last_group_sum
      last_group_sum = group_sum
    end
    count
  end
end

puts DepthFinder.new.num_increasing_group_depths
