class Rope
  def initialize
    @input = File.readlines('input').map { |line| line.strip.split(' ') }
    @tail_locations = []
    @head_x = 0
    @head_y = 0
    @tail_x = 0
    @tail_y = 0
  end

  def num_cells_tail_has_visited
    @input.each do |direction, distance|
      distance.to_i.times do
        move_head(direction)
        move_tail
        record_tail_location
      end
    end

    @tail_locations.uniq.size
  end

  private

  def move_head(direction)
    case direction
    when 'U'
      @head_y += 1
    when 'D'
      @head_y -= 1
    when 'R'
      @head_x += 1
    when 'L'
      @head_x -= 1
    end
  end

  def move_tail
    if (@tail_x - @head_x ).abs > 1
      if @tail_x < @head_x
        @tail_x += 1
      else
        @tail_x -= 1
      end

      @tail_y = @head_y if @tail_y != @head_y
    end

    if (@tail_y - @head_y).abs > 1
      if @tail_y < @head_y
        @tail_y += 1
      else
        @tail_y -= 1
      end

      @tail_x = @head_x if @tail_x != @head_x
    end
  end

  def record_tail_location
    @tail_locations << [@tail_x, @tail_y]
  end
end

puts Rope.new.num_cells_tail_has_visited
