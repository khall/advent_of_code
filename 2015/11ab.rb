class Password
  attr_accessor :str

  def initialize(str)
    @str = str
  end

  def next_valid
    while increment
      break if valid?
    end
  end

  def increment
    @str = str.next
  end

  def valid?
    !invalid_letters? && two_pairs? && increasing_letters?
  end

  private

  def increasing_letters?
    bytes = str.bytes
    bytes.each_index do |i|
      return true if bytes[i] + 1 == bytes[i + 1] && bytes[i] + 2 == bytes[i + 2]
    end
    false
  end

  def invalid_letters?
    %w(i o l).each do |letter|
      return true if str.include?(letter)
    end
    false
  end

  def two_pairs?
    consecutive_letter_regex = /([a-z])\1/
    if str.match(consecutive_letter_regex)
      str.sub(consecutive_letter_regex, '_').match(consecutive_letter_regex)
    end
  end
end

password = Password.new('cqjxjnds')
password.next_valid
puts password.str
password.next_valid
puts password.str
