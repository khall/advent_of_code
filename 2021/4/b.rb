require 'byebug'

class SquidBingo
  def initialize
    input = File.readlines('input').map { |n| n.strip }
    @called_numbers = input.shift.split(',').map(&:to_i)
    input.shift
    @boards = []

    while input.size > 0
      @boards << BingoBoard.new(input.shift(5).map { |row| row.split(' ').map(&:to_i) })
      input.shift
    end
  end

  def calculate_score
    won_index = []
    @called_numbers.each do |called_number|
      @boards.each_with_index do |board, i|
        board.mark_number(called_number) unless won_index.include?(i)
        if board.winner? && !won_index.include?(i)
          if won_index.size < @boards.size - 1
            won_index << i
          else
            return board.unmarked_numbers_sum * called_number
          end
        end
      end
    end
  end
end

class BingoBoard
  def initialize(array)
    @array = array
    @rotated_array = array.transpose
  end

  def mark_number(called_num)
    @array.each_with_index do |row, i|
      row.each_with_index do |num, j|
        if called_num == num
          @array[i][j] = 'X'
          @rotated_array[j][i] = 'X'
          break
        end
      end
    end
  end

  def unmarked_numbers_sum
    @array.flatten.map(&:to_i).sum
  end

  def winner?
    @array.any? do |row|
      row.all? { |num| num == 'X' }
    end || @rotated_array.any? do |col|
      col.all? { |num| num == 'X' }
    end
  end
end

puts SquidBingo.new.calculate_score
