# frozen_string_literal: true

require_relative 'train'

# type train is passenger
class PassengerTrain < Train
  def initialize(number)
    super(number, Passenger)
  end
end
