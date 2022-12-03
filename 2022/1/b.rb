class MealList
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def max_calories
    counts = []
    running = 0

    @input.each do |calories|
      if calories.empty?
        counts << running
        running = 0
        next
      end

      running += calories.to_i
    end

    counts.max(3).sum
  end
end

puts MealList.new.max_calories
