# frozen_string_literal: true

# tempaltes for interfeces
class Templates
  def self.show_carriage(train)
    train.carriages_list do |carriage, i|
      puts "\t\tВагон: ##{i}, " \
      "тип: #{carriage.type}, " \
      "производитель: #{carriage.company}, " \
      "занято: #{carriage.units} у.е., " \
      "свободно: #{carriage.max_units} у.е."
    end
  end
end
