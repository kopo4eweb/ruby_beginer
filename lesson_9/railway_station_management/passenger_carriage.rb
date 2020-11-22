# frozen_string_literal: true

require_relative 'carriage'
require_relative 'validation'

# type carriage is passenger
class PassengerCarriage < Carriage
  extend Validation

  validate :max_units, :positive, 'Не задано кол-во мест в вагоне'

  def initialize(max_units)
    @max_units = max_units
    validate!
    super(Passenger, max_units)
  end
end
