class CleanupAssignment
  def initialize
    @input = File.readlines('input').map { |n|
      one, two = n.strip.split(',')
      [one.split('-').map(&:to_i), two.split('-').map(&:to_i)]
    }
  end

  def num_complete_overlaps
    @input.select do |(lower_1, upper_1), (lower_2, upper_2)|
      (lower_1 >= lower_2 && upper_1 <= upper_2) || (lower_2 >= lower_1 && upper_2 <= upper_1)
    end.size
  end
end

puts CleanupAssignment.new.num_complete_overlaps
