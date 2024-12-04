class WordSearch
  def initialize(word)
    @matches = File.readlines('input').map { |row| row.strip.split('') }
    @str = word.upcase
  end

  def count
    count_matches(original_input) +
    count_matches(rotated_input) +
    count_matches(top_left_diagonal_input) +
    count_matches(top_right_diagonal_input)
  end

  private

  def count_matches(array)
    array.sum { |row| row.join.scan(@str).size } + array.sum { |row| row.join.reverse.scan(@str).size }
  end

  def original_input
    @matches
  end

  def rotated_input
    @matches.transpose
  end

  # top left is top
  def top_left_diagonal_input
    top_left_array = []
    x = 0
    y = @str.size - 1
    row = []

    loop do
      row << @matches.dig(y, x) if @matches.dig(y, x)
      y -= 1
      x += 1

      if y < 0
        break if row.size < @str.size
        y = x
        x = 0
        top_left_array << row
        row = []
      end
    end

    top_left_array
  end

  # top right is top
  def top_right_diagonal_input
    top_left_array = []
    x = width - @str.size
    y = 0
    row = []

    loop do
      row << @matches.dig(y, x) if @matches.dig(y, x) && y >= 0 && x >= 0
      y += 1
      x += 1

      if x > width
        break if row.size < @str.size
        x = width - y
        y = 0
        top_left_array << row
        row = []
      end
    end

    top_left_array
  end

  def width
    @matches.first.size
  end

  def height
    @matches.size
  end
end

puts WordSearch.new('xmas').count
