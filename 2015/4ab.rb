require 'digest/md5'
INPUT = 'iwrupvqb'

def lowest_md5(leading_num)
  n = 0
  while true do
    return n if num_leading_zeros?(Digest::MD5.hexdigest("#{INPUT}#{n}"), leading_num)
    n += 1
  end
end

def num_leading_zeros?(str, num)
  index = num - 1
  str[0..index] == '0' * num
end

puts lowest_md5(5)
puts lowest_md5(6)
