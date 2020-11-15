require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize(max_units)
    @max_units = max_units
    validate!
    super(TYPE[:passenger], max_units)
  end

  private
    def validate!
      raise ArgumentError, 'Не задано кол-во мест в вагоне' if @max_units.to_i <= 0
    end
end