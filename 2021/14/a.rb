require 'byebug'

class ExtendedPolymerization
  def initialize
    input = File.readlines('input').map { |n| n.strip }
    @template = input.shift
    @rules = input[1..-1].map { |row| row.split(' -> ') }.to_h
  end

  def difference_between_greatest_and_least_elements_after_ten_steps
    10.times do
      new_template = ''
      last_index = @template.size - 1
      last_index.times do |start_index|
        key = @template.slice(start_index, 2)
        new_template += "#{key[0]}#{@rules[key]}"
      end
      @template = new_template + @template[-1]
    end

    sorted_counts = @template.split('').tally.values.sort
    sorted_counts[-1] - sorted_counts[0]
  end
end

puts ExtendedPolymerization.new.difference_between_greatest_and_least_elements_after_ten_steps
