require 'byebug'

class SevenSegment
  def initialize
    @input = File.readlines('input').map { |line| line.strip.split(' | ') }
  end

  def sum_seven_segment_numbers
    @input.map do |signals, number|
      signal_mapping = map_signal_patterns_to_digits(signals.split(' '))
      number_from_signal_mapping(signal_mapping, number)
    end.sum
  end

  private

  def map_signal_patterns_to_digits(signals)
    one = signals.detect { |signal| signal.size == 2 }
    four = signals.detect { |signal| signal.size == 4 }
    seven = signals.detect { |signal| signal.size == 3 }
    eight = signals.detect { |signal| signal.size == 7 }
    six = signals.detect { |signal| signal.size == 6 && (signal.split('') & seven.split('')).size != 3 }
    five = signals.detect { |signal| signal.size == 5 && (signal.split('') & six.split('')).size == 5 }
    two = signals.detect { |signal| signal.size == 5 && (signal.split('') & five.split('')).size == 3 }
    three = signals.detect { |signal| signal.size == 5 && ![five, two].include?(signal) }
    nine = signals.detect { |signal| signal.size == 6 && (signal.split('') & three.split('')).size == 5 }
    zero = signals.detect { |signal| signal.size == 6 && ![nine, six].include?(signal) }

    [zero, one, two, three, four, five, six, seven, eight, nine].map.with_index do |key, i|
      [key.split('').sort.join(''), i]
    end.to_h
  end

  def number_from_signal_mapping(mapping, number)
    number.split(' ').map { |digit| mapping[digit.split('').sort.join('')] }.join.to_i
  end
end

puts SevenSegment.new.sum_seven_segment_numbers
