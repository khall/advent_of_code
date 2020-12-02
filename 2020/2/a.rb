class Password
  def initialize(min:, max:, password:, required_char:)
    @min = min.to_i
    @max = max.to_i
    @password = password
    @required_char = required_char
  end

  def valid?
    (min..max).include? password.count(required_char)
  end

  private

  attr_reader :min, :max, :password, :required_char
end

class PasswordValidator
  def initialize
    @input = File.readlines('input').map do |line|
      range, char, password = line.split(' ')
      min, max = range.split('-')
      Password.new(min: min, max: max, required_char: char[0], password: password)
    end
  end

  def num_valid
    input.count(&:valid?)
  end

  private

  attr_reader :input
end

puts PasswordValidator.new.num_valid
