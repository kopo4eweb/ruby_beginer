# Create stations
@stations = [ 
  Station.new("ст. Начальная 1"),
  Station.new("ст. Начальная 2"),
  Station.new("ст. Конечная 1"),
  Station.new("ст. Конечная 2")
]

5.times { |i| @stations << Station.new("ст. Промежуточная #{i + 1}") }

# Create routes
@routes << Route.new(@stations[0], @stations[2])

@routes << Route.new(@stations[1], @stations[3])
@routes.last.add_station(@stations[4])
@routes.last.add_station(@stations[5])
@routes.last.add_station(@stations[6])

@routes << Route.new(@stations[0], @stations[3])
@routes.last.add_station(@stations[7])
@routes.last.add_station(@stations[8])

# Create trains
@trains << CargoTrain.new('МЕГА грузовой')
@trains << PassengerTrain.new('Сапсан - коженные мешки')