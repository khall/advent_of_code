class CleanupAssignment
  STR_LEN = 4

  def initialize
    @input = File.readlines('input').first.strip.chars
  end

  def num_complete_overlaps
    @input.each_with_index do |char, i|
      next if i < STR_LEN
      return i if @input[i - STR_LEN, STR_LEN].uniq.size == STR_LEN
    end
  end
end

puts CleanupAssignment.new.num_complete_overlaps
