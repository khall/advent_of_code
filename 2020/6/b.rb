class QuestionResponseCounter
  def initialize
    @input = File.readlines('input').map(&:strip)
  end

  def num
    group_counts = []
    group_answers = []

    xor_array_size = -> (answers) { answers.inject(('a'..'z').to_a) { |accum, answers| accum & answers }.size }

    input.map do |answers|
      if answers.empty?
        group_counts << xor_array_size.call(group_answers)
        group_answers = []
        next
      end

      group_answers << answers.chars
    end

    group_counts << xor_array_size.call(group_answers)
    group_counts.sum
  end

  private

  attr_reader :input

end

puts QuestionResponseCounter.new.num
