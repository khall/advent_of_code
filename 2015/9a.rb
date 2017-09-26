require './9_input'

class Route
  attr_accessor :cities, :paths, :shortest_route, :shortest_route_length

  def initialize
    @paths = INPUT.split("\n").split(/( to | = )/)
    @cities = @paths.map(&:first).flatten.uniq
    # @city_paths = { }
    # @cities.each do |city|
    #   @city_paths[city] = []
    # end
  end

  def brute_force
    sorted_paths = paths.map { |path| path.strip.split(' = ') }.sort_by { |path| path[1].to_i }

  end

  def build_all_valid_routes

  end

  def build_all_possible_routes

  end

  # routes: [[city1, city2, distance], [city2, city3, distance], ...]
  def select_valid_routes(routes)
    routes.select do |route|
      route.map { |r| r[0] }
    end
  end
end

Route.new.brute_force
