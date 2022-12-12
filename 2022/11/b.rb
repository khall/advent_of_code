require 'byebug'
class Monkey
  attr_accessor :starting_items, :operation, :operator, :divisible_by, :true_monkey, :false_monkey, :inspection_count

  def initialize(starting_items, operation, divisible_by, true_monkey, false_monkey)
    @starting_items = starting_items.split(', ').map(&:to_i)
    @operation, @operator = operation
    # puts "operation: #{@operation}, operator: #{@operator}"
    @divisible_by = divisible_by
    @true_monkey = true_monkey
    @false_monkey = false_monkey
    @inspection_count = 0
  end

  def throw_items(monkeys)
    starting_items.each do |item|
      adjusted_operator = @operator == 'old' ? item : @operator
      new_worry = item.public_send(operation, adjusted_operator.to_i)
      if new_worry % divisible_by == 0
        monkeys[true_monkey].starting_items << new_worry
      else
        monkeys[false_monkey].starting_items << new_worry
      end
      @inspection_count += 1
    end
    @starting_items = []
  end
end

class MonkeyBusiness
  def initialize
    @monkeys = []
    @input = File.open('input') do |file|
      until file.eof? do
        line = file.readline
        next if line == "\n"

        starting_item = file.readline.split(': ').last
        operation = file.readline.split(' ').last(2)
        divisible_by = file.readline.split(' ').last.to_i
        true_monkey = file.readline.split(' ').last.to_i
        false_monkey = file.readline.split(' ').last.to_i
        @monkeys << Monkey.new(starting_item, operation, divisible_by, true_monkey, false_monkey)
      end
    end
  end

  def perform
    10_000.times do |i|
      puts "Round #{i}"
      @monkeys.each do |monkey|
        monkey.throw_items(@monkeys)
      end
    end

    @monkeys.map(&:inspection_count).max(2).inject(:*)
  end
end

puts MonkeyBusiness.new.perform
