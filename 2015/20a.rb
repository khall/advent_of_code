def factors(num)
  found_list = []
  (num ** 0.5).floor.downto(1).each do |n|
    no_remainder = (num % n == 0)
    if no_remainder
      found_list << n
      found_list << (num / n)
    end
  end
  found_list
end

minimum_presents = File.readlines('20_input').first.chomp.to_i
house_num = 1
loop do
  factors = factors(house_num)
  factor_sum = factors.sum * 10
  break if factor_sum > minimum_presents
  house_num += 1
end

puts house_num
