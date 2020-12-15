class CPU
  def initialize
    @input = File.readlines('input').map do |line|
      instruction, value = line.strip.split(' ')
      [instruction, value.to_i]
    end
    @accumulator = 0
    @current_instruction = 0
    @swap_instruction = true
  end

  def accumulator_after_fixing_infinite_loop
    alternative_branch = []
    executed_instructions = []

    while executing = input[current_instruction] do
      instruction, value = executing

      if executed_instructions.include?(current_instruction)
        @current_instruction, @accumulator, executed_instructions = alternative_branch.pop
        executing = input[current_instruction]
        instruction, value = executing
        execute_instruction([], instruction, value, executed_instructions)
        @swap_instruction = true
        next
      end
      executed_instructions << current_instruction

      execute_instruction(alternative_branch, instruction, value, executed_instructions)
    end

    accumulator
  end

  private

  attr_reader :accumulator, :current_instruction, :input, :swap_instruction

  def execute_instruction(alternative_branch, instruction, value, executed_instructions)
    case instruction
    when 'acc'
      acc(value)
    when 'jmp'
      if swap_instruction
        @swap_instruction = false
        alternative_branch << [current_instruction, accumulator, executed_instructions.dup]
        nop(value)
      else
        jmp(value)
      end
    when 'nop'
      if swap_instruction
        @swap_instruction = false
        alternative_branch << [current_instruction, accumulator, executed_instructions.dup]
        jmp(value)
      else
        nop(value)
      end
    end
  end

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

puts CPU.new.accumulator_after_fixing_infinite_loop
