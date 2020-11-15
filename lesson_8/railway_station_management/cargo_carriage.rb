# frozen_string_literal: true

require_relative 'carriage'

# type carriage is cargo
class CargoCarriage < Carriage
  def initialize(max_units)
    @max_units = max_units
    validate!
    super(TYPE[:cargo], max_units)
  end

  private

  def validate!
    raise ArgumentError, 'Не задан объем вагона' if @max_units.to_i <= 0
  end
end
