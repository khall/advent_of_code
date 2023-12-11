class ToyBoatRace
  def initialize
    @input = File.readlines('input').map { |n| n.split(':').last.tr(' ', '').strip.split(' ') }.transpose.flatten
  end

  def num_ways_to_win_product
    race_length, distance_record = @input
    distances = []

    race_length.to_i.times do |time_holding_button|
      distances << (race_length.to_i - time_holding_button) * time_holding_button
    end

    distances.count { |distance| distance > distance_record.to_i }
  end
end

puts ToyBoatRace.new.num_ways_to_win_product
