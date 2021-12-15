require 'byebug'

class OctopusFlashing
  def initialize
    @input = File.readlines('input').map { |n| n.strip.split('').map(&:to_i) }
  end

  def flashes_in_one_hundred_steps
    loop.with_index do |_, num|
      @flash_count = 0
      step
      spawn_flashes
      reset_flashers
      return num + 1 if @flash_count == 100
    end
  end

  private

  def step
    10.times do |i|
      10.times do |j|
        @input[i][j] += 1
      end
    end
  end

  def spawn_flashes
    still_flashing = true

    while still_flashing
      still_flashing = false

      10.times do |i|
        10.times do |j|
          if @input[i][j].to_i > 9
            @input[i][j] = nil
            flash_coordinate(i, j)
            still_flashing = true
          end
        end
      end
    end
  end

  def flash_coordinate(i, j)
    coordinates_to_flash = [
      [i - 1, j - 1], [i - 1, j], [i - 1, j + 1],
      [i, j - 1], [i, j], [i, j + 1],
      [i + 1, j - 1], [i + 1, j], [i + 1, j + 1],
    ].reject { |a, b| a < 0 || a > 9 || b < 0 || b > 9 }

    coordinates_to_flash.each do |flash_i, flash_j|
      @input[flash_i][flash_j] += 1 unless @input[flash_i][flash_j].nil?
    end
  end

  def reset_flashers
    10.times do |i|
      10.times do |j|
        if @input[i][j].nil?
          @input[i][j] = 0
          @flash_count += 1
        end
      end
    end
  end
end

puts OctopusFlashing.new.flashes_in_one_hundred_steps
