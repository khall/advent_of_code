class Computer
  def initialize
    @input = File.readlines('input').map { |line| line.strip }
  end

  def sum_of_directories_less_than_100k
    parent_dirs = []
    sizes = {}
    sizes.default = 0

    @input.each do |output|
      if output[0] == '$'
        if output.start_with?('$ cd')
          if output == '$ cd ..'
            parent_dirs.pop
          else
            parent_dirs << output.split(' ')[2]
          end
        elsif output == '$ ls'
          next
        end
      else
        # output of ls
        match_data = output.match(/(\d+) .+/)
        next if match_data.nil?
        parent_dirs.size.times do |n|
          sizes[parent_dirs[0..n]] += match_data[1].to_i
        end
      end
    end

    puts sizes
    sizes.values.sum { |size| size <= 100_000 ? size : 0 }
  end
end

puts Computer.new.sum_of_directories_less_than_100k
