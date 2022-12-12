class CRT
  INTERESTING_SIGNAL_STRENGTHS = [20, 60, 100, 140, 180, 220].freeze

  def initialize
    @input = File.readlines('input').map { |line| line.strip.split(' ') }
    @register_history = [1]
  end

  def sum_signal_strengths
    @input.each do |instruction, param|
      case instruction
      when 'noop'
        @register_history << @register_history.last
      when 'addx'
        @register_history << @register_history.last
        @register_history << @register_history.last + param.to_i
      end
    end

    puts @register_history.size
    INTERESTING_SIGNAL_STRENGTHS.inject(0) do |sum, index|
      sum + (@register_history[index - 1] * index)
    end
  end
end

puts CRT.new.sum_signal_strengths
