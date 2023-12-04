class TrebuchetCalibration
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  NUM_WORDS = { one: 1, two: 2, three: 3, four: 4, five: 5, six: 6, seven: 7, eight: 8, nine: 9 }

  def sum_first_last_ints
    @input.sum do |line|
      new_line = ''
      line.size.times do |i|
        NUM_WORDS.each do |word, int|
          if line[i..-1].start_with?(word.to_s)
            new_line += int.to_s
            break
          elsif line[i].match?(/[1-9]/)
            new_line += line[i]
            break
          end
        end
      end
      new_line.tr!('a-z', '')
      (new_line[0] + new_line[-1]).to_i
    end
  end
end

puts TrebuchetCalibration.new.sum_first_last_ints
