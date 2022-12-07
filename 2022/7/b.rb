class Computer
  TOTAL_SIZE = 70_000_000
  NEEDED_FREE_SPACE = 30_000_000

  def initialize
    @input = File.readlines('input').map { |line| line.strip }
  end

  def size_of_directory_to_delete
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
        puts "parent_dirs: #{parent_dirs}, output: #{output}, match_data: #{match_data}"
        parent_dirs.size.times do |n|
          sizes[parent_dirs[0..n]] += match_data[1].to_i
        end
      end
    end

    current_free_space = TOTAL_SIZE - sizes[['/']].to_i
    minimum_size_to_delete = NEEDED_FREE_SPACE - current_free_space

    sizes.values.select { |size| size >= minimum_size_to_delete }.min
  end
end

puts Computer.new.size_of_directory_to_delete
