class WordSearch
  SQUARE_MIDDLE = 1
  SQUARE_SIZE = 3

  def initialize(word)
    @matches = File.readlines('input').map { |row| row.strip.split('') }
    @str = word.upcase
  end

  def count
    x = 0
    y = 0
    num_matches = 0

    while y + SQUARE_SIZE - 1 < height
      while x + SQUARE_SIZE - 1 < width
        num_matches += 1 if match?(@matches, x, y)
        x += 1
      end
      x = 0
      y += 1
    end

    num_matches
  end

  private

  def match?(arr, x, y)
    masked_array = mask(arr, x, y)

    possible_answers.any? do |answer|
      match = true

      answer.each_with_index do |answer_row, i|
        unless masked_array[i].join.match?(answer_row)
          match = false
          break
        end
      end

      return true if match
    end
  end

  def mask(arr, x, y)
    arr[y..(y + 2)].map do |row|
      row[x..(x + 2)]
    end
  end

  def possible_answers
    [
      [
        'M.S',
        '.A.',
        'M.S'
      ],
      [
        'M.M',
        '.A.',
        'S.S'
      ],
      [
        'S.M',
        '.A.',
        'S.M'
      ],
      [
        'S.S',
        '.A.',
        'M.M'
      ]
    ]
  end

  def width
    @matches.first.size
  end

  def height
    @matches.size
  end
end

puts WordSearch.new('mas').count
