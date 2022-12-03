class Rucksack
  CHAR_TO_INT = (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index.inject({}) do |hash, (char, i)|
    hash[char] = i + 1
    hash
  end

  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def priority_sum
    @input.sum do |items_str|
      halfway_index = (items_str.size / 2)
      common_letter = (items_str[0..halfway_index - 1].chars & items_str[halfway_index..-1].chars).first
      CHAR_TO_INT[common_letter]
    end
  end
end

puts Rucksack.new.priority_sum
