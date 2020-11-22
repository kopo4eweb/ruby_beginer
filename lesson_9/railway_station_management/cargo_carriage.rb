# frozen_string_literal: true

require_relative 'carriage'
require_relative 'validation'

# type carriage is cargo
class CargoCarriage < Carriage
  extend Validation

  validate :max_units, :positive, 'Не задан объем вагона'

  def initialize(max_units)
    @max_units = max_units
    validate!
    super(Cargo, max_units)
  end
end
