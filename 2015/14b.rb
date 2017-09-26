require './14_input'

class Reindeer
  attr_accessor :speed, :travel_time, :rest_time, :distance, :state, :next_action, :points

  def initialize(speed, travel_time, rest_time)
    @speed = speed
    @travel_time = travel_time
    @rest_time = rest_time
    @distance = 0
    @state = :resting
    @next_action = 0
    @points = 0
  end

  def liftoff
    @state = :flying
    @next_action += travel_time
  end

  def fly
    @distance += speed
  end

  def land
    @state = :resting
    @next_action += rest_time
  end

  def rest
    # nothing
  end

  def ready_to_fly?(timer)
    state == :resting && next_action == timer
  end

  def ready_to_rest?(timer)
    state == :flying && next_action == timer
  end

  def flying?
    state == :flying
  end

  def add_point
    @points += 1
  end
end

def launch_reindeers(seconds)
  reindeers = []
  INPUT.split("\n").each do |row|
    data = row.match(/(\d+) km\/s for (\d+) seconds, .+ (\d+) seconds.$/)
    reindeers << Reindeer.new(data[1].to_i, data[2].to_i, data[3].to_i)
  end

  run_seconds(reindeers, seconds)
end

def run_seconds(reindeers, seconds)
  seconds.times do |n|
    reindeers.each do |reindeer|
      fly_or_rest(reindeer, n)
    end
    furthest = reindeers.map(&:distance).max
    reindeers.select { |reindeer| reindeer.distance == furthest }.each { |reindeer| reindeer.add_point }
  end

  puts reindeers.map(&:points).max
end

def fly_or_rest(reindeer, timer)
  if reindeer.ready_to_fly?(timer)
    # time to fly
    reindeer.liftoff
    reindeer.fly
  elsif reindeer.ready_to_rest?(timer)
    reindeer.land
    reindeer.rest
  elsif reindeer.flying?
    reindeer.fly
  else
    reindeer.rest
  end
end

launch_reindeers(2503)
