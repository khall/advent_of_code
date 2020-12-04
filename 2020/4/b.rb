class PassportValidator
  def initialize(hash)
    hash.default = ''
    @byr = hash['byr'].to_i
    @ecl = hash['ecl']
    @eyr = hash['eyr'].to_i
    @hcl = hash['hcl']
    @hgt = hash['hgt']
    @iyr = hash['iyr'].to_i
    @pid = hash['pid']
  end

  def to_s
    "byr: #{@byr}, ecl: #{@ecl}, eyr: #{@eyr}, hcl: #{@hcl}, pid: #{@pid}, iyr: #{@iyr}, hgt: #{@hgt}"
  end

  def valid?
    valid_byr? && valid_iyr? && valid_eyr? && valid_hgt? && valid_hcl? && valid_ecl? && valid_pid?
  end

  private

  def valid_byr?
    (1920..2002).include? @byr
  end

  def valid_ecl?
    %w(amb blu brn gry grn hzl oth).include?(@ecl)
  end

  def valid_eyr?
    (2020..2030).include? @eyr
  end

  def valid_hcl?
    @hcl.match?(/#[0-9a-f]{6}/)
  end

  def valid_hgt?
    if @hgt.end_with?('cm')
      (150..193).include? @hgt[0..-2].to_i
    elsif @hgt.end_with?('in')
      (59..76).include? @hgt[0..-2].to_i
    else
      false
    end
  end

  def valid_iyr?
    (2010..2020).include? @iyr
  end

  def valid_pid?
    @pid.match?(/\A\d{9}\z/)
  end
end

class PassportCheckpoint
  IGNORED_FIELDS = %w(cid)
  REQUIRED_FIELDS = %w(byr ecl eyr hcl hgt iyr pid)

  def initialize
    @input = File.
      read('input').
      split("\n\n").
      map { |str| eval "{ #{str.gsub(/(\S+):(\S+)\b/, '"\1" => "\2", ') } }" }. # so dirty and unsafe
      map { |hash| PassportValidator.new(hash) }
  end

  def num_valid
    input.count(&:valid?)
  end

  private

  attr_reader :input
end

puts PassportCheckpoint.new.num_valid
