require 'byebug'
class Item
  attr_accessor :name, :cost, :damage, :armor, :type

  def initialize(name, cost, damage, armor, type)
    @name = name
    @cost = cost.to_i
    @damage = damage.to_i
    @armor = armor.to_i
    @type = type
  end

  def to_s
    "name: #{name}, cost: #{cost}, damage: #{damage}, armor: #{armor}, type: #{type}"
  end
end

class Shop
  attr_accessor :weapon_list, :armor_list, :ring_list

  def initialize(items)
    @weapon_list = []
    @armor_list = []
    @ring_list = []

    [:weapon, :armor, :ring].each do |type|
      parse_item_list(items[type]).each do |name, cost, damage, armor|
        instance_variable_get("@#{type}_list") << Item.new(name, cost, damage, armor, type)
      end
    end
  end

  private

  def parse_item_list(list)
    list.split("\n")[1..-1].map { |row| row.split(/ {2,}/) }
  end
end

class Warrior
  attr_accessor :hitpoints, :damage, :armor

  def initialize(damage = 0, armor = 0, hitpoints = 100)
    @damage = damage
    @armor = armor
    @hitpoints = hitpoints
  end

  def equip_items(weapon, armor, ring1, ring2)
    @damage = weapon.damage + armor.damage + ring1.damage + ring2.damage
    @armor = weapon.armor + armor.armor + ring1.armor + ring2.armor
  end
end

class Fight
  attr_accessor :warrior, :opponent

  def initialize(warrior)
    @warrior = warrior
    load_opponent
  end

  def warrior_wins?
    while (warrior.hitpoints > 0 && opponent.hitpoints > 0) do
      opponent.hitpoints -= [warrior.damage - opponent.armor, 1].max
      break if opponent.hitpoints <= 0
      warrior.hitpoints -= [opponent.damage - warrior.armor, 1].max
    end
    warrior.hitpoints > 0
  end

  private

  def load_opponent
    data = Hash[*File.readlines('21_input').map(&:chomp).map{ |r| r.split(/: /) }.flatten]
    @opponent = Warrior.new(data['Damage'].to_i, data['Armor'].to_i, data['Hit Points'].to_i)
  end
end

class Arena
  attr_accessor :shop

  WEAPON_LIST = <<~WEAPONS
  Weapons:    Cost  Damage  Armor
  Dagger        8     4       0
  Shortsword   10     5       0
  Warhammer    25     6       0
  Longsword    40     7       0
  Greataxe     74     8       0
  WEAPONS

  ARMOR_LIST = <<~ARMOR
  Armor:      Cost  Damage  Armor
  None          0     0       0
  Leather      13     0       1
  Chainmail    31     0       2
  Splintmail   53     0       3
  Bandedmail   75     0       4
  Platemail   102     0       5
  ARMOR

  RING_LIST = <<~RINGS
  Rings:      Cost  Damage  Armor
  None          0     0       0
  Damage +1    25     1       0
  Damage +2    50     2       0
  Damage +3   100     3       0
  Defense +1   20     0       1
  Defense +2   40     0       2
  Defense +3   80     0       3
  RINGS

  def initialize
    load_shop
  end

  def cheapest_win
    cheapest_equipment = nil
    @shop.weapon_list.each do |weapon|
      @shop.armor_list.each do |armor|
        @shop.ring_list.each do |ring1|
          @shop.ring_list.each do |ring2|
            next if ring1 == ring2 && ring1.name != 'None'
            total_cost = weapon.cost + armor.cost + ring1.cost + ring2.cost
            next if cheapest_equipment && total_cost > cheapest_equipment
            warrior = Warrior.new(0, 0, 100)
            warrior.equip_items(weapon, armor, ring1, ring2)
            if Fight.new(warrior).warrior_wins?
              cheapest_equipment = total_cost
            end
          end
        end
      end
    end
    cheapest_equipment
  end

  private

  def load_shop
    @shop = Shop.new({ weapon: WEAPON_LIST, armor: ARMOR_LIST, ring: RING_LIST })
  end
end


puts Arena.new.cheapest_win
