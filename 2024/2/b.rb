class Reactor
  def initialize
    @input = File.readlines('input').map { |n| n.split(' ').map(&:to_i) }
  end

  def num_safe_reports
    good_reports = @input.select do |report|
      (increasing?(report) || decreasing?(report)) && gradual_level_change?(report)
    end
    bad_reports = @input - good_reports
    bad_reports.each do |report|
      report.size.times do |i|
        report_copy = report.dup
        report_copy.delete_at(i)
        if (increasing?(report_copy) || decreasing?(report_copy)) && gradual_level_change?(report_copy)
          good_reports << report
          break
        end
      end
    end
    good_reports.size
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
