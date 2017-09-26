require './9_input'

class Routes
  attr_accessor :cities, :paths, :longest_route_length

  def initialize
    @paths = INPUT.split("\n").map do |line|
      broken_line = line.split(/( = )/)
      [broken_line[0], broken_line[2]]
    end.to_h
    @cities = @paths.map do |path|
      path.first.sub(/ to /, ' ').split(' ')
    end.flatten.uniq
    @city_paths = cities.permutation.to_a
  end

  def find_longest_route
    @city_paths.each do |path|
      path_length = 0
      path.each_with_index do |city, i|
        next_city = path[i + 1]
        break if next_city.nil?
        path_length += route_length("#{city} to #{next_city}")
      end
      if longest_route_length.nil? || path_length > longest_route_length
        @longest_route_length = path_length
      end
    end
  end

  def route_length(str)
    reversed_str = str.split(' ').reverse.join(' ')
    (@paths[str] || @paths[reversed_str]).to_i
  end
end

routes = Routes.new
routes.find_longest_route
puts routes.longest_route_length
