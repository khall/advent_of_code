aunts = File.readlines('16_input')
aunt_attributes = aunts.map { |a| Hash[*(a.chomp.split(/: |, /)[1..-1])] }

desired_attributes = { children: 3,
                       cats: 7,
                       samoyeds: 2,
                       pomeranians: 3,
                       akitas: 0,
                       vizslas: 0,
                       goldfish: 5,
                       trees: 3,
                       cars: 2,
                       perfumes: 1 }

i = 0
found = aunt_attributes.detect do |attributes|
  i += 1
  attributes.all? do |k, v|
    desired_attributes[k.to_sym] == v.to_i
  end
end

puts i
