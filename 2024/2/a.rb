class Reactor
  def initialize
    @input = File.readlines('input').map { |n| n.split(' ').map(&:to_i) }
  end

  def num_safe_reports
    @input.select { |report| (increasing?(report) || decreasing?(report)) && gradual_level_change?(report) }.size
  end

  private

  def increasing?(levels)
    levels == levels.sort
  end

  def decreasing?(levels)
    levels.reverse == levels.sort
  end

  def gradual_level_change?(levels)
    levels[0..-2].each_with_index do |level, i|
      diff = (level - levels[i + 1]).abs
      return false if diff < 1 || 3 < diff
    end
    true
  end
end

puts Reactor.new.num_safe_reports
