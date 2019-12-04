class Computer
  attr_reader :input, :noun, :position, :verb

  def initialize(noun, verb)
    @noun = noun
    @verb = verb
    load_input
    @position = 0
  end

  def execute_all
    loop do
      break unless execute_instruction
    end
  end

  def position_zero
    input[0]
  end

  private

  def load_instruction
    instruction = input[position]
    input1 = input[position + 1]
    input2 = input[position + 2]
    output = input[position + 3]
    @position += 4
    return instruction, input1, input2, output
  end

  def execute_instruction
    instruction, input1, input2, output = load_instruction
    return false if instruction == 99

    case instruction
    when 1
      add(input1, input2, output)
    when 2
      multiply(input1, input2, output)
    end
  end

  def add(input1, input2, output)
    input[output] = input[input1] + input[input2]
  end

  def multiply(input1, input2, output)
    input[output] = input[input1] * input[input2]
  end

  def load_input
    @input = File.read('input').split(',').map { |n| n.strip.to_i }
    set_noun_and_verb
  end

  def set_noun_and_verb
    input[1] = noun
    input[2] = verb
  end
end

EXPECTED = 19690720

(0..99).each do |noun|
  (0..99).each do |verb|
    computer = Computer.new(noun, verb)
    computer.execute_all
    puts "Noun: #{noun}\nVerb: #{verb}" if EXPECTED == computer.position_zero
  end
end
