class QuestionResponseCounter
  def initialize
    @input = File.readlines('input').map(&:strip)
  end

  def num
    group_counts = []
    group_answers = []

    input.map do |answers|
      if answers.empty?
        group_counts << group_answers.flatten.uniq.size
        group_answers = []
        next
      end

      group_answers << answers.chars
    end

    group_counts << group_answers.flatten.uniq.size
    group_counts.sum
  end

  private

  attr_reader :input

end

puts QuestionResponseCounter.new.num
