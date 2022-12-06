class Crane
  def initialize
    stacks_done = false
    @stacks = Array.new(10) { [] }
    @movements = []

    File.readlines('input').each do |line|
      if line.strip == '1   2   3   4   5   6   7   8   9' || line.strip.empty?
        stacks_done = true
        next
      end

      if stacks_done
        movement_line = line.strip.split(' ').map(&:to_i)
        @movements << [movement_line[1], movement_line[3], movement_line[5]]
      else
        populate_stack(@stacks, line)
      end
    end

    @stacks.each(&:reverse!)
  end

  def move_stacks
    @movements.each do |num, from, to|
      num.times do
        @stacks[to].push @stacks[from].pop
      end
    end

    @stacks.map(&:last).join('')
  end

  private

  def populate_stack(stacks, line)
    char_indexes = [1, 5, 9, 13, 17, 21, 25, 29, 33]

    9.times do |n|
      stacks[n + 1] << line[char_indexes[n]] unless line[char_indexes[n]].to_s.strip.empty?
    end
  end
end

puts Crane.new.move_stacks
