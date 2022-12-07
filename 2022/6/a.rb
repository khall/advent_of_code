class RepeatingChars
  STR_LEN = 4

  def initialize
    @input = File.readlines('input').first.strip.chars
  end

  def index_of_non_repeating_chars
    @input.each_with_index do |char, i|
      next if i < STR_LEN
      return i if @input[i - STR_LEN, STR_LEN].uniq.size == STR_LEN
    end
  end
end

puts RepeatingChars.new.index_of_non_repeating_chars
