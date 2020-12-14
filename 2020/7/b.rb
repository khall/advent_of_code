class BaggageRules
  def initialize
    @input = File.readlines('input').to_h do |str|
      outer_bag_name, inner_bag_str = str.split(' bags contain ')
      inner_bag_data = inner_bag_str.chop.split(', ').map do |name|
        matched_data = name.match(/(\d+|no) ([a-z ]+) bags?\.?\Z/)
        num = matched_data[1]
        stripped_bag_name = matched_data[2]
        [num.to_i, stripped_bag_name]
      end
      [outer_bag_name, inner_bag_data]
    end
  end

  def num_bags_inside(examined_bag_name)
    bag_count = input[examined_bag_name].sum do |num, name|
      return 1 if num == 0
      num * num_bags_inside(name)
    end
    bag_count + 1
  end

  private

  attr_reader :input
end

puts BaggageRules.new.num_bags_inside('shiny gold') - 1
