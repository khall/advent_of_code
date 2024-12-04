class Computer
  def initialize
    input_str = File.read('input')
    @matches = input_str.scan /mul\(\d{1,3},\d{1,3}\)/
  end

  def sum_products
    @matches.sum do |match|
      multiplier, multiplicand = match[4..-2].split(',')
      multiplier.to_i * multiplicand.to_i
    end
  end
end

puts Computer.new.sum_products
