class Printer
  def initialize
    rows = File.readlines('input').map { |row| row.strip }
    separation_row_num = rows.index('')
    @rules = rows[0..separation_row_num - 1].map { |rule_row| rule_row.split('|') }
    @updates = rows[separation_row_num + 1..-1].map { |update_row| update_row.split(',') }
  end

  def sum_middle_valid_updates
    @updates.sum do |update|
      valid?(update) ? update[update.size / 2].to_i : 0
    end
  end

  private

  def valid?(update)
    update.size.times do |update_item_iterator|
      update_item_iterator.times do |prior_update_item_iterator|
        return false unless @rules.include?([update[prior_update_item_iterator], update[update_item_iterator]])
      end
    end

    true
  end
end

puts Printer.new.sum_middle_valid_updates
