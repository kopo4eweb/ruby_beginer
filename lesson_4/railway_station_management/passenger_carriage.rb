require_relative 'carriage'

class PassengerCarriage < Carriage
  def initialize()
    super(TYPE[:passenger])
  end
end