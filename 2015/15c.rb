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
      texture: texture * num,
      calories: calories * num }
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
      amounts.size.times do
        score = calculate_score(amounts.rotate!)
        max_score = score if score > max_score
      end
    end
    max_score
  end

  private

  def possible_combinations
    (1..100).to_a.repeated_combination(4).to_a.select do |a, b, c, d|
      a + b + c + d == 100
    end
  end

  def calculate_score(amounts)
    ingredient_hashes = []
    4.times do |n|
      ingredient_hashes << ingredients[n] * amounts[n]
    end

    calories_sum = ingredient_hashes.map { |hash| hash[:calories] }.sum
    return 0 if calories_sum != 500
    capacity_sum = ingredient_hashes.map { |hash| hash[:capacity] }.sum
    durability_sum = ingredient_hashes.map { |hash| hash[:durability] }.sum
    flavor_sum = ingredient_hashes.map { |hash| hash[:flavor] }.sum
    texture_sum = ingredient_hashes.map { |hash| hash[:texture] }.sum

    [0, capacity_sum].max *
      [0, durability_sum].max *
      [0, flavor_sum].max *
      [0, texture_sum].max
  end
end

puts Cookie.new.maximum_score
