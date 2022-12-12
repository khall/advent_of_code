class CRT
  def initialize
    @input = File.readlines('input').map { |line| line.strip.split(' ') }
    @register_history = [1]
  end

  def sum_signal_strengths
    display_array = Array.new(240, '.')

    @input.each_with_index do |(instruction, param), i|
      puts "i: #{i}, register: #{@register_history.last}"
      display_array[i] = '#' if ((@register_history.last - 1)..(@register_history.last + 1)).include?(i % 40)

      case instruction
      when 'noop'
        @register_history << @register_history.last
      when 'addx'
        @register_history << @register_history.last
        @input.insert(i + 1, ['addnow', param.to_i])
      when 'addnow'
        @register_history << @register_history.last + param.to_i
      end
    end

    puts display_array.each_slice(40).to_a.map { |a| a.join('') }
  end
end

CRT.new.sum_signal_strengths
