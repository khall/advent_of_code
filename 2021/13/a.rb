require 'byebug'

class Origami
  def initialize
    @dots = []
    @instructions = []

    max_x = 0
    max_y = 0
    File.readlines('input').map do |row|
      if row.include?(',')
        x, y = row.strip.split(',').map(&:to_i)
        max_x = x if x > max_x
        max_y = y if y > max_y
        @dots << [x, y]
      elsif row.start_with?('fold along')
        direction, value = row.delete_prefix('fold along ').split('=')
        @instructions << [direction, value.to_i]
      end
    end
    @map = Array.new(max_y + 1) { Array.new(max_x + 1) }
    @dots.each do |x, y|
      @map[y][x] = 1
    end
  end

  def visible_dots_after_one_fold
    @instructions.first(1).each do |axis, value|
      if axis == 'x'
        fold_along_column(value)
      elsif axis == 'y'
        fold_along_row(value)
      end
    end

    @map.flatten.count(1)
  end

  private

  def fold_along_column(fold_column)
    @map.each_with_index do |row, i|
      row.each_with_index do |_cell, j|
        break if fold_column == j

        @map[i][j] ||= @map[i][fold_column * 2 - j]
        @map[i][fold_column * 2 - j] = nil
      end
    end
  end

  def fold_along_row(fold_row)
    @map.each_with_index do |row, i|
      return if fold_row == i

      row.each_with_index do |_cell, j|
        @map[i][j] ||= @map[fold_row * 2 - i][j]
        @map[fold_row * 2 - i][j] = nil
      end
    end
  end
end

puts Origami.new.visible_dots_after_one_fold
