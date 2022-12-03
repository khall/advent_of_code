class MealList
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def max_calories
    max = 0
    running = 0

    @input.each do |calories|
      if calories.empty?
        max = running if running > max
        running = 0
        next
      end

      running += calories.to_i
    end

    max
  end
end

puts MealList.new.max_calories
