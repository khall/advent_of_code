class Computer
  def initialize
    input_str = File.read('input')
    @matches = input_str.scan(/(mul\(\d{1,3},\d{1,3}\)|don't\(\)|do\(\))/).flatten
  end

  def sum_products
    sum = 0
    disabled = false

    @matches.each do |match|
      if match == "don't()"
        disabled = true
        next
      elsif match == 'do()'
        disabled = false
        next
      end

      next if disabled

      multiplier, multiplicand = match[4..-2].split(',')
      sum += multiplier.to_i * multiplicand.to_i
    end

    sum
  end
end

puts Computer.new.sum_products
