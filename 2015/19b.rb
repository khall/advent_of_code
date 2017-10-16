translation_strs = File.readlines('19_input').map(&:chomp)
molecule = translation_strs.pop
translation_strs.pop

translations = Hash.new([])
translation_strs.each do |translation|
  value, key = translation.split(' => ')
  translations[key] = value
end

new_molecule = molecule

old_molecule_length = 0
steps = 0
while new_molecule != 'e' do
  break if old_molecule_length == new_molecule.length
  old_molecule_length = new_molecule.length
  translations.each do |k, v|
    replacement_index = new_molecule.index(k)
    unless replacement_index.nil?
      new_molecule[replacement_index, k.length] = v
      steps += 1
    end
  end
end

puts steps
