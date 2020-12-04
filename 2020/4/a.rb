class PassportValidator
  IGNORED_FIELDS = %w(cid)
  REQUIRED_FIELDS = %w(byr ecl eyr hcl hgt iyr pid)

  def initialize
    @input = File.read('input').split("\n\n").map { |str| str.scan(/(\w{3}):\S+/).sort.flatten - IGNORED_FIELDS }
  end

  def num_valid
    input.count { |fields| fields == REQUIRED_FIELDS }
  end

  private

  attr_reader :input
end

puts PassportValidator.new.num_valid
