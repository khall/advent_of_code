class CPU
  def initialize
    @input = File.readlines('input').map do |line|
      instruction, value = line.strip.split(' ')
      [instruction, value.to_i]
    end
    @accumulator = 0
    @current_instruction = 0
  end

  def accumulator_when_infinite_loop_begins
    executed_instructions = []
    while executing = input[current_instruction] do
      instruction, value = executing
      puts "inst: #{current_instruction}, acc: #{accumulator} -- for #{instruction} #{value}"
      break if executed_instructions.include?(current_instruction)
      executed_instructions << current_instruction

      case instruction
      when 'acc'
        acc(value)
      when 'jmp'
        jmp(value)
      when 'nop'
        nop(value)
      end
    end

    accumulator
  end

  private

  attr_reader :accumulator, :current_instruction, :input

  def acc(val)
    @accumulator += val
    @current_instruction += 1
  end

  def jmp(val)
    @current_instruction += val
  end

  def nop(val)
    @current_instruction += 1
  end
end

puts CPU.new.accumulator_when_infinite_loop_begins
