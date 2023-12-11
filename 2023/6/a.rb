class ToyBoatRace
  def initialize
    @input = File.readlines('input').map { |n| n.split(':').last.gsub(/ +/, ' ').strip.split(' ') }.transpose
  end

  def num_ways_to_win_product
    ways_to_win = []

    @input.each do |race_length, distance_record|
      distances = []

      race_length.to_i.times do |time_holding_button|
        distances << (race_length.to_i - time_holding_button) * time_holding_button
      end

      ways_to_win << distances.count { |distance| distance > distance_record.to_i }
    end

    ways_to_win.inject(1) { |product, multiplier| product * multiplier }
  end
end

puts ToyBoatRace.new.num_ways_to_win_product
