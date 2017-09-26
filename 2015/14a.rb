require './14_input'

def launch_reindeers(seconds)
  reindeers = []
  INPUT.split("\n").each do |row|
    data = row.match(/(\d+) km\/s for (\d+) seconds, .+ (\d+) seconds.$/)
    reindeers << { speed: data[1].to_i, travel_time: data[2].to_i, rest_time: data[3].to_i }
  end

  calculate_all_distances(reindeers, seconds)
end

def calculate_all_distances(reindeers, seconds)
  max_distance = 0

  reindeers.each do |reindeer|
    curr = calculate_distance(reindeer, seconds)
    max_distance = [max_distance, curr].max
  end
  puts max_distance
end

def calculate_distance(reindeer, seconds, distance = 0)
  if reindeer[:travel_time] + reindeer[:rest_time] > seconds
    # partial
    if reindeer[:travel_time] <= seconds
      # can complete full travel distance
      distance += reindeer[:travel_time] * reindeer[:speed]
      return distance
    else
      # partial travel distance
      distance += seconds * reindeer[:speed]
      return distance
    end
  else
    seconds -= reindeer[:travel_time] + reindeer[:rest_time]
    distance += reindeer[:travel_time] * reindeer[:speed]
    calculate_distance(reindeer, seconds, distance)
  end
end

launch_reindeers(2503)
