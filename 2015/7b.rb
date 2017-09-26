require './7_input'

def parse_and_eval
  lookup_table = { 'b' => 46065 }
  connections = INPUT.split("\n")
  while lookup_table['a'].nil?
    connections.each do |connection|
      parsed = parse(connection)
      replace_inputs(lookup_table, parsed)
      if inputs_obtained?(parsed) && parsed[:output] != 'b'
        lookup_table[parsed[:output]] = eval_inputs(parsed)
      end
    end
  end
  puts "a: #{lookup_table['a']}"
end

def replace_inputs(table, parsed)
  input1 = parsed[:input1]
  input2 = parsed[:input2]
  if input1.match(/[a-z]/) && table[input1]
    parsed[:input].gsub!(/#{input1}/, table[input1].to_s)
    parsed[:input1] = table[input1]
  end
  if input2 && input2.match(/[a-z]/) && table[input2]
    parsed[:input].gsub!(/#{input2}/, table[input2].to_s)
    parsed[:input2] = table[input2]
  end
end

def inputs_obtained?(parsed)
  parsed[:input].match(/[a-z]/).nil?
end

def eval_inputs(parsed)
  input1 = parsed[:input1].to_i
  input2 = parsed[:input2].to_i
  case parsed[:action]
    when 'NOT'
      # worry about 16-bit 0-65535
      bitwise_not = ~input1
      converted = 65535 - (bitwise_not.abs - 1)
      puts "shit. bitwise not went negative. was: #{input1} now: #{bitwise_not} -- converted to: #{converted}"
      converted
    when 'AND'
      input1 & input2
    when 'OR'
      input1 | input2
    when 'RSHIFT'
      input1 >> input2
    when 'LSHIFT'
      input1 << input2
    else
      # no action, just pass through
      input1
  end
end

def parse(connection)
  input_output = connection.split(' -> ')
  action_match = input_output[0].match(/[A-Z]+/)
  action = action_match.nil? ? 'NONE' : action_match[0]
  input1, input2 = input_output[0].split - [action]
  { input: input_output[0], output: input_output[1], action: action, input1: input1, input2: input2 }
end

parse_and_eval
