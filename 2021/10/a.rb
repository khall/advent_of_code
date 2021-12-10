class SyntaxScoring
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def syntax_error_score
    invalid_characters.map { |char| score(char) }.sum
  end

  private

  def invalid_characters
    invalid_character_list = []

    @input.each do |line|
      stack = []
      line.split('').each do |char|

        if %w|( [ { <|.include?(char)
          stack << char
        else
          if closing_char?(stack.last, char)
            stack.pop
          else
            invalid_character_list << char
            break
          end
        end
      end
    end

    invalid_character_list
  end

  def closing_char?(opening_char, closing_char)
    { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }[opening_char] == closing_char
  end

  def score(char)
    case char
    when ')'
      3
    when ']'
      57
    when '}'
      1197
    when '>'
      25137
    end
  end
end

puts SyntaxScoring.new.syntax_error_score
