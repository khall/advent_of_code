class Forest
  def initialize
    @input = File.readlines('input').map { |line| line.strip.chars }
  end

  def num_visible_trees
    forest_height = @input.size
    forest_width = @input.first.size

    visible_tree_array = Array.new(forest_height) { Array.new(forest_width, ' ') }
    visible_tree_array[0] = Array.new(forest_width, 'x')
    visible_tree_array[-1] = Array.new(forest_width, 'x')
    visible_tree_array.each { |row| row[0] = 'x'; row[-1] = 'x' }

    @input.each_with_index do |row, y|
      if y == 0 || y == (forest_height - 1)
        next
      else
        left_edge_height = row[0].to_i
        row.each_with_index do |tree_height, x|
          if tree_height.to_i > left_edge_height
            visible_tree_array[y][x] = 'x'
            left_edge_height = tree_height.to_i
          end
        end

        left_edge_height = row[-1].to_i
        row.to_enum.with_index.reverse_each do |tree_height, x|
          if tree_height.to_i > left_edge_height
            visible_tree_array[y][x] = 'x'
            left_edge_height = tree_height.to_i
          end
        end
      end
    end

    @input.transpose.each_with_index do |row, x|
      if x == 0 || x == (forest_height - 1)
        next
      else
        left_edge_height = row[0].to_i
        row.each_with_index do |tree_height, y|
          puts "---x: #{x}, y: #{y}, tree_height: #{tree_height}, left_edge_height: #{left_edge_height}" if x == 1
          if tree_height.to_i > left_edge_height
            visible_tree_array[y][x] = 'x'
            left_edge_height = tree_height.to_i
          end
        end

        left_edge_height = row[-1].to_i
        row.to_enum.with_index.reverse_each do |tree_height, y|
          puts "x: #{x}, y: #{y}, tree_height: #{tree_height}, left_edge_height: #{left_edge_height}" if x == 1
          if tree_height.to_i > left_edge_height
            visible_tree_array[y][x] = 'x'
            left_edge_height = tree_height.to_i
          end
        end
      end
    end

    # puts visible_tree_array.map { |row| row.join(' ') }
    visible_tree_array.flatten.count('x')
  end
end

puts Forest.new.num_visible_trees
