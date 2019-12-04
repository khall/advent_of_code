class PasswordGuesser
  class << self
    LOW_RANGE = 130254
    HIGH_RANGE = 678275

    def num_possible_passwords
      (LOW_RANGE..HIGH_RANGE).to_a.reduce(0) do |count, num|
        (increasing?(num) && same_adjacent?(num)) ? count + 1 : count
      end
    end

    private

    def increasing?(num)
      nums = num.to_s.split('').map(&:to_i)
      nums[0] <= nums[1] && nums[1] <= nums[2] && nums[2] <= nums[3] && nums[3] <= nums[4] && nums[4] <= nums[5]
    end

    def same_adjacent?(num)
      str = num.to_s
      str[0] == str[1] || str[1] == str[2] || str[2] == str[3] || str[3] == str[4] || str[4] == str[5]
    end
  end
end

puts PasswordGuesser.num_possible_passwords
