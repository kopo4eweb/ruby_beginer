# frozen_string_literal: true

# test data
class Seeds
  class << self
    def init
      stations
      routes
      trains
    end

    def stations
      # Create stations
      Interface.stations << Station.new('ст. Начальная 1')
      Interface.stations << Station.new('ст. Начальная 2')
      Interface.stations << Station.new('ст. Конечная 1')
      Interface.stations << Station.new('ст. Конечная 2')

      5.times do |i|
        Interface.stations << Station.new("ст. Промежуточная #{i + 1}")
      end
    end

    def routes
      # Create routes
      Interface.routes << Route.new(Interface.stations[0], Interface.stations[2])

      Interface.routes << Route.new(Interface.stations[1], Interface.stations[3])
      Interface.routes.last.add_station(Interface.stations[4])
      Interface.routes.last.add_station(Interface.stations[5])
      Interface.routes.last.add_station(Interface.stations[6])

      Interface.routes << Route.new(Interface.stations[0], Interface.stations[3])
      Interface.routes.last.add_station(Interface.stations[7])
      Interface.routes.last.add_station(Interface.stations[8])
    end

    def trains
      # Create trains
      cargo_train = CargoTrain.new('Z4ш4t')
      cargo_train.company = 'Simense'
      Interface.trains << cargo_train
      Interface.trains.last.route(Interface.routes[0])
      # p cargo_train.valid?
      1.upto(7) do |i|
        carriage = CargoCarriage.new(10 + i)
        carriage.company = 'Cargo Builder Inc.'
        cargo_train.add_carriage(carriage)
      end
      # p cargo_train.carriages
      cargo_train.carriages_list { |carriage| p carriage.add_unit }
      # p cargo_train.carriages

      puts '--------------------'

      Interface.trains << PassengerTrain.new('xx6-yy')
      train = Interface.trains.last
      train.route(Interface.routes[1])
      1.upto(3) do |i|
        carriage = PassengerCarriage.new(20 + i * 2)
        carriage.company = 'Pass Dev Inc.'
        train.add_carriage(carriage)
      end
      # p train.carriages

      Interface.trains << CargoTrain.new('123-v5')
      train = Interface.trains.last
      train.route(Interface.routes[1])
      # p train.carriages

      Interface.trains << PassengerTrain.new('67u-ew')
      train = Interface.trains.last
      train.route(Interface.routes[2])
      # p train.carriages

      # Stations
      # Interface.stations[0].get_trains { |train| p train }
      # Interface.stations[1].get_trains { |train| p train.number }
      Interface.stations[1].get_trains(&:go_ahead)
      # Interface.stations[0].get_trains { |train| train.speed = 33 }
    end
  end
end
