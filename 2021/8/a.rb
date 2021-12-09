class SevenSegment
  def initialize
    @input = File.readlines('input').flat_map do |line|
      pipe_index = line.index('|')
      line[(pipe_index + 1)..-1].strip.split(' ')
    end
  end

  def count_unique_digits
    @input.count { |word| [2, 3, 4, 7].include?(word.size) }
  end
end

puts SevenSegment.new.count_unique_digits
