require 'byebug'

class Ingredient
  attr_accessor :name, :capacity, :durability, :flavor, :texture, :calories

  def initialize(name, attributes)
    @name = name
    attributes.each do |k, v|
      instance_variable_set("@#{k}", v.to_i)
    end
  end

  def *(num)
    { capacity: capacity * num,
      durability: durability * num,
      flavor: flavor * num,
      texture: texture * num }
  end
end

class Cookie
  attr_accessor :ingredients

  def initialize
    @ingredients = []
    load_ingredients
  end

  def load_ingredients
    File.open('15_input').read.split("\n").each do |line|
      name = line.match(/\A(.+?): (.+)\Z/)[1]
      attributes = Regexp.last_match(2).split(', ').map do |attr|
        attr.split(' ')
      end.to_h
      ingredients << Ingredient.new(name, attributes)
    end
  end

  def maximum_score
    max_score = 0
    possible_combinations.each do |amounts|
      score = calculate_score(amounts)
      puts score
      max_score = score if score > max_score
    end
    max_score
  end

  private

  def possible_combinations
    combinations_500_calories = []
    (1..100).to_a.repeated_combination(4).to_a.each do |order|
      next unless order.sum == 100

      order.size.times do |x|
        rotated_order = order.rotate!
        # puts rotated_order.join(', ')
        sum = 0
        ingredients.each_with_index do |ingredient, i|
          sum += ingredient.calories * rotated_order[i]
        end

        combinations_500_calories << rotated_order.dup if sum == 500
      end
    end
    combinations_500_calories
  end

  def calculate_score(amounts)
    ingredient_hashes = []
    4.times do |n|
      ingredient_hashes << ingredients[n] * amounts[n]
    end

    capacity_sum = ingredient_hashes.sum { |hash| hash[:capacity] }
    durability_sum = ingredient_hashes.sum { |hash| hash[:durability] }
    flavor_sum = ingredient_hashes.sum { |hash| hash[:flavor] }
    texture_sum = ingredient_hashes.sum { |hash| hash[:texture] }

    [0, capacity_sum].max *
      [0, durability_sum].max *
      [0, flavor_sum].max *
      [0, texture_sum].max
  end
end

puts Cookie.new.maximum_score
