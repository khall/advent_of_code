class PackageOrder
  NUM_GROUPS = 3

  def initialize
    @input = File.readlines('24_input').map { |n| n.strip.to_i }
  end

  def entanglement_of_group(group_num)
    specified_group = evenly_divide.
      select { |*groups| groups.all? { |g| g.sum == mean_sum } }.
      sort { |a, b| a.size <=> b.size }[group_num]
    quantum_entanglement(specified_group)
  end

  private

  def mean_sum
    @mean_sum ||= @input.sum / @input.size
  end

  def evenly_divide_by_weight
    @input.combination(@input.size).
  end

  def quantum_entanglement(packages)
    packages.reduce(1) { |acc, package| acc * package }
  end
end

puts PackageOrder.new.entanglement_of_group(0) == 99
