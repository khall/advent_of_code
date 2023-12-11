class ScratchCard
  def initialize
    @input = File.readlines('input').map do |n|
      winning_numbers, my_numbers = n.split(':').last.split('|')
      [winning_numbers.split(' '), my_numbers.split(' ')]
    end
  end

  def sum_cards
    card_matches = []
    @input.each_with_index do |(winning_numbers, my_numbers), i|
      card_matches[i] = (winning_numbers & my_numbers).size
    end

    num_cards = Array.new(@input.size, 1)
    card_matches.each_with_index do |_num_matches, i|
      card_matches[i].times { |j| num_cards[i + j + 1] += num_cards[i] }
    end

    num_cards.sum
  end
end

puts ScratchCard.new.sum_cards
