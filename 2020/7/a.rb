class BaggageRules
  def initialize
    @input = File.readlines('input').to_h do |str|
      outer_bag_name, inner_bag_str = str.split(' bags contain ') #(/(.+) bags contain (.+)./)
      inner_bag_names = inner_bag_str.chop.split(', ').map do |name|
        name.delete('0-9').delete_prefix('no ').sub(/bags?\.?/, '').strip
      end
      [outer_bag_name, inner_bag_names]
    end
    @possible_bags = []
  end

  def num_bags_can_contain(examined_bag_name)
    possible_bags << examined_bag_name
    parent_bags = input.select { |_parent_bag, inner_bag_names| inner_bag_names.include?(examined_bag_name) }

    return if parent_bags.empty?

    parent_bags.keys.each { |bag| num_bags_can_contain(bag) }
    possible_bags.uniq.size - 1
  end

  private

  attr_reader :input, :possible_bags
end

puts BaggageRules.new.num_bags_can_contain('shiny gold')
