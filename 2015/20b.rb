def factors(num)
  minimum = [num / 50, 1].max
  found_list = []

  (num ** 0.5).floor.downto(1).each do |n|
    no_remainder = (num % n == 0)
    if no_remainder
      found_list << n unless n < minimum
      found_list << (num / n) unless (num / n) < minimum
    end
  end
  found_list
end

minimum_presents = File.readlines('20_input').first.chomp.to_i / 11
house_num = 1
loop do
  factor_list = factors(house_num)
  break if factor_list.sum > minimum_presents
  house_num += 1
end

puts house_num
