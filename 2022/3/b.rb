class Rucksack
  CHAR_TO_INT = (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index.inject({}) do |hash, (char, i)|
    hash[char] = i + 1
    hash
  end

  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def group_badge_sum
    @input.each_slice(3).to_a.map do |rucksack_1, rucksack_2, rucksack_3|
      common_letter = ((rucksack_1.chars & rucksack_2.chars) & rucksack_3.chars).first
      CHAR_TO_INT[common_letter]
    end.sum
  end
end

puts Rucksack.new.group_badge_sum
