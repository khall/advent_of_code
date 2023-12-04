class TrebuchetCalibration
  def initialize
    @input = File.readlines('input').map { |n| n.strip }
  end

  def sum_first_last_ints
    @input.sum do |line|
      only_ints = line.tr('a-z', '')
      (only_ints[0] + only_ints[-1]).to_i
    end
  end
end

puts TrebuchetCalibration.new.sum_first_last_ints
