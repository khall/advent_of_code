class SyntaxScoring
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def autocomplete_score
    scores = incomplete_characters.map { |char| score(char) }.sort
    scores[scores.size / 2]
  end

  private

  def incomplete_characters
    incomplete_character_list = []

    @input.each do |line|
      stack = []
      line.split('').each do |char|

        if %w|( [ { <|.include?(char)
          stack << char
        else
          if closing_char(stack.last) == char
            stack.pop
          else
            stack = []
            break
          end
        end
      end

      unless stack.empty?
        incomplete_character_list << stack.map { |opening_char| closing_char(opening_char) }.reverse
      end
    end

    incomplete_character_list
  end

  def closing_char(opening_char)
    { '(' => ')', '[' => ']', '{' => '}', '<' => '>' }[opening_char]
  end

  def score(closing_chars)
    char_scores = { ')' => 1, ']' => 2, '}' => 3, '>' => 4 }
    closing_chars.inject(0) do |cur_score, char|
      5 * cur_score + char_scores[char]
    end
  end
end

puts SyntaxScoring.new.autocomplete_score
