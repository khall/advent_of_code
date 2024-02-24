require 'byebug'

class CamelCards
  def initialize
    @input = File.readlines('input').map { |n| n.split(' ') }
  end

  def total_winnings
    hands = get_poker_hands_by_type
    order_hands(hands)
    calculate_winnings(hands)
  end

  private

  def get_poker_hands_by_type
    hands = { five: [], four: [], full: [], three: [], two: [], one: [], high: [] }
    @input.each do |hand, bid|
      tally = hand.chars.tally.sort { |a, b| b[1] <=> a[1] }
      case tally[0][1]
      when 5
        # five of a kind
        hands[:five] << [hand, bid]
      when 4
        # four of a kind
        hands[:four] << [hand, bid]
      when 3
        # three of a kind / full house
        if tally[1][1] == 2
          # full house
          hands[:full] << [hand, bid]
        else
          # three of a kind
          hands[:three] << [hand, bid]
        end
      when 2
        # one / two pairs
        if tally[1][1] == 2
          # two pair
          hands[:two] << [hand, bid]
        else
          # one pair
          hands[:one] << [hand, bid]
        end
      when 1
        hands[:high] << [hand, bid]
      end
    end
    hands
  end

  def order_hands(hands)
    hands.each do |hand_type, hands_of_type|
      hands[hand_type] = hands_of_type.map { |hand, bid| [hand.tr('A', 'E').tr('K', 'D').tr('Q', 'C').tr('J', 'B').tr('T', 'A'), bid] }.sort { |hand_arr_a, hand_arr_b| hand_arr_a[0] <=> hand_arr_b[0] }
    end
  end

  def calculate_winnings(hands)
    hand_order = %i[high one two three full four five]
    hand_count = 1
    winnings = 0
    hand_order.each do |hand_name|
      hands[hand_name].each do |_hand, bid|
        winnings += bid.to_i * hand_count
        hand_count += 1
      end
    end
    winnings
  end
end

puts CamelCards.new.total_winnings
