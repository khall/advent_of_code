translation_strs = File.readlines('19_input').map(&:chomp)
molecule = translation_strs.pop
translation_strs.pop

translations = Hash.new([])
translation_strs.each do |translation|
  key, value = translation.split(' => ')
  translations[key] = [] if !translations.key?(key)
  translations[key] << value
end

new_molecules = []

molecule.split('').each_with_index do |letter, i|
  next if letter.downcase == letter
  next_letter = molecule[i + 1]
  range = i
  if next_letter.downcase == next_letter
    letter += next_letter
    range = (i..i + 1)
  end
  translations[letter].each do |substitute|
    molecule_copy = molecule.dup
    molecule_copy[range] = substitute
    new_molecules << molecule_copy
  end
end

puts new_molecules.uniq.size
