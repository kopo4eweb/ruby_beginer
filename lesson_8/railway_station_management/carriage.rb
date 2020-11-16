# frozen_string_literal: true

require_relative 'types'
require_relative 'company'

# base class carriage
class Carriage
  include Company

  attr_reader :type, :units, :max_units

  def initialize(type, max_units)
    @type = type
    @max_units = max_units
    @units = 0
  end

  def add_unit
    error_message = 'Вагон заполнен'
    raise ArgumentError, error_message if @max_units.zero?

    @units += 1
    @max_units -= 1
  end
end
