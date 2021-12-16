require 'byebug'

class ExtendedPolymerization
  def initialize
    input = File.readlines('input').map { |n| n.strip }
    @template = input.shift
    @rules = input[1..-1].map { |row| row.split(' -> ') }.to_h
    @bigrams = Hash[('AA'..'ZZ').to_a.map { |str| [str, 0] }]
    last_index = @template.size - 1
    last_index.times do |start_index|
      @bigrams[@template.slice(start_index, 2)] += 1
    end
  end

  def difference_between_greatest_and_least_elements_after_ten_steps
    40.times do |n|
      new_bigrams = @bigrams.dup

      new_bigrams.reject { |_k, v| v == 0 }.each do |bigram_str, bigram_count|
        new_bigram1 = "#{bigram_str[0]}#{@rules[bigram_str]}"
        new_bigram2 = "#{@rules[bigram_str]}#{bigram_str[1]}"
        new_bigrams[bigram_str] -= bigram_count
        new_bigrams[new_bigram1] += bigram_count
        new_bigrams[new_bigram2] += bigram_count
      end

      @bigrams = new_bigrams
    end

    char_count = Hash[('A'..'Z').to_a.map { |str| [str, 0] }]
    @bigrams.each do |k, v|
      first_char, second_char = k.split('')
      char_count[first_char] += v
    end
    char_count[@template[0]] += 1
    char_count[@template[-1]] += 1 unless @template[0] == @template[-1]

    counts = char_count.values.reject { |n| n.zero? }.sort
    counts[-1] - counts[0]
  end
end

puts ExtendedPolymerization.new.difference_between_greatest_and_least_elements_after_ten_steps
