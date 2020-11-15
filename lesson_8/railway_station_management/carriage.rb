require_relative 'types'
require_relative 'company'

class Carriage
  include Company

  attr_reader :type, :units, :max_units

  def initialize(type, max_units)
    @type = type
    @max_units = max_units
    @units = 0
  end

  def add_unit
    raise ArgumentError, 'Вагон заполнен' if @max_units == 0
    @units += 1
    @max_units -= 1
  end
end