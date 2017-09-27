require './13_input'

class DiningTable
  attr_accessor :people, :preferences

  def initialize
    load_seating_preferences
    load_people
    load_me
  end

  def optimal_seating_happiness
    best_happiness = 0
    people.permutation(people.size).to_a.each do |seating_arrangement|
      happiness = calculate_happiness(seating_arrangement)
      best_happiness = happiness if happiness > best_happiness
    end
    best_happiness
  end

  private

  def load_seating_preferences
    @preferences = INPUT.split("\n").map do |line|
      line.match(/\A(.+?) would (gain|lose) (\d+) .+ (.+?)\.\Z/)
      loss_or_gain = Regexp.last_match(2) == 'gain' ? 1 : -1
      points = Regexp.last_match(3).to_i * loss_or_gain
      key = "#{Regexp.last_match(1)}_#{Regexp.last_match(4)}"
      [key, points]
    end.to_h
  end

  def load_people
    @people = preferences.keys.flat_map { |key| key.split('_') }.uniq
  end

  def load_me
    my_name = 'me'
    @people << my_name
    @people.each do |person|
      @preferences["#{my_name}_#{person}"] = 0
      @preferences["#{person}_#{my_name}"] = 0
    end
  end

  def calculate_happiness(seating_list)
    happiness = 0
    seating_list.each_with_index do |person, i|
      left_key = "#{person}_#{seating_list[i - 1]}"
      next_person = seating_list[i + 1] || seating_list[0]
      right_key = "#{person}_#{next_person}"
      happiness += preferences[left_key] + preferences[right_key]
    end
    happiness
  end
end

puts DiningTable.new.optimal_seating_happiness
