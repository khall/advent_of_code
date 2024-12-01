class Distance
  def initialize
    @first_input, @second_input = File.readlines('input').map { |n| n.split(' ') }.transpose
  end

  def similarity_score
    @first_input = @first_input.map(&:to_i).sort
    @second_input = @second_input.map(&:to_i).sort

    sum = 0
    @first_input.each_with_index do |num, i|
      sum += (num * @second_input.count(num))
    end
    sum
  end
end

puts Distance.new.similarity_score
