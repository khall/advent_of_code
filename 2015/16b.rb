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
operator = { children: '==',
             cats: '>',
             samoyeds: '==',
             pomeranians: '<',
             akitas: '==',
             vizslas: '==',
             goldfish: '<',
             trees: '>',
             cars: '==',
             perfumes: '==' }

i = 0
aunt_attributes.detect do |attributes|
  i += 1
  attributes.all? do |k, v|
    v.to_i.public_send(operator[k.to_sym], desired_attributes[k.to_sym])
  end
end

puts i
