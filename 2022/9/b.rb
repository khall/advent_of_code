require 'byebug'

class Position
  attr_accessor :x, :y

  def initialize
    @x = 0
    @y = 0
  end
end

class Rope
  def initialize
    @input = File.readlines('input').map { |line| line.strip.split(' ') }
    @tail_locations = []
    @body_positions = Array.new(10) { Position.new}
  end

  def num_cells_tail_has_visited
    @input.each do |direction, distance|
      distance.to_i.times do
        puts "#{direction} #{distance} -- #{@body_positions.map { |pos| "#{pos.x},#{pos.y}" }.join(' ') }"
        move_head(direction)
        9.times do |i|
          move_segment(i + 1)
          record_tail_location
        end
      end
    end

    @tail_locations.uniq.size
  end

  private

  def head_position
    @body_positions[0]
  end

  def move_head(direction)
    case direction
    when 'U'
      head_position.y += 1
    when 'D'
      head_position.y -= 1
    when 'R'
      head_position.x += 1
    when 'L'
      head_position.x -= 1
    end
  end

  def move_segment(segment_num)
    segment_position = @body_positions[segment_num]
    previous_segment_position = @body_positions[segment_num - 1]

    if (segment_position.x - previous_segment_position.x).abs > 1
      if segment_position.x < previous_segment_position.x
        segment_position.x += 1
      else
        segment_position.x -= 1
      end

      if segment_position.y != previous_segment_position.y
        if (segment_position.y - previous_segment_position.y).abs == 2
          segment_position.y = previous_segment_position.y / 2
        else
          segment_position.y += 1
        end
      end
    end

    if (segment_position.y - previous_segment_position.y).abs > 1
      if segment_position.y < previous_segment_position.y
        segment_position.y += 1
      else
        segment_position.y -= 1
      end

      if segment_position.x != previous_segment_position.x
        if (segment_position.x - previous_segment_position.x).abs == 2
          segment_position.x = previous_segment_position.x / 2
        else
          segment_position.x += 1
        end
      end
    end
  end

  def record_tail_location
    @tail_locations << [@body_positions.last.x, @body_positions.last.y]
  end
end

puts Rope.new.num_cells_tail_has_visited
