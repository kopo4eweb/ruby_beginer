require_relative 'carriage'

class CargoCarriage < Carriage
  def initialize()
    super(TYPE[:cargo])
  end
end