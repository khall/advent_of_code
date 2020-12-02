class Password
  def initialize(index_list:, password:, required_char:)
    @index_list = index_list
    @password = password
    @required_char = required_char
  end

  def valid?
    index_list.one? { |index| password[index - 1] == required_char }
  end

  private

  attr_reader :index_list, :password, :required_char
end

class PasswordValidator
  def initialize
    @input = File.readlines('input').map do |line|
      range, char, password = line.split(' ')
      Password.new(index_list: range.split('-').map(&:to_i), required_char: char[0], password: password)
    end
  end

  def num_valid
    input.count(&:valid?)
  end

  private

  attr_reader :input
end

puts PasswordValidator.new.num_valid
