class ScratchCard
  def initialize
    @input = File.readlines('input').map do |n|
      winning_numbers, my_numbers = n.split(':').last.split('|')
      [winning_numbers.split(' '), my_numbers.split(' ')]
    end
  end

  def sum_points
    points = [0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512]
    @input.inject(0) do |sum, (winning_numbers, my_numbers)|
      sum + points[(winning_numbers & my_numbers).size]
    end
  end
end

puts ScratchCard.new.sum_points
