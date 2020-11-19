# frozen_string_literal: true

require_relative 'train'

# type train is cargo
class CargoTrain < Train
  def initialize(number)
    super(number, TYPE[:cargo])
  end
end
