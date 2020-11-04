@route = nil

def route(route)
  return if route.nil?

  @route = route

  loop do
    puts 'Введите цифру - выберите действие:'
    puts '1 - Список станций на маршруте'
    puts '2 - Добавить станцию на маршрут'
    puts '3 - Удалить станцию с маршрута'
    puts '0 - Вернуться в меню маршрутов'
    print '>> '

    operation = gets.chomp
    operation = -1 if operation.empty?

    puts "\n"

    case operation.to_i
      when 0
        break
      when 1
        puts '--> Список станций на маршруте'
        route_info(@route)
      when 2
        puts '--> Добавить станцию на маршрут'
        add_station()
      when 3
        puts '--> Удалить станцию с маршрута'
        remove_station()
    else
      puts '! Неизвестная операция'
    end

    puts "\n"
  end
end

def route_info(route)  
  route.stations.each_with_index { |station, index| puts "\t#{index + 1} - #{station.name}" }
end

def add_station
  show_stations() # показать все станции что есть

  puts 'Введите номер станции для добавления её в маршрут:'
  print '>> '
  station = @stations[gets.chomp.to_i - 1]
  @route.add_station(station)
end

def remove_station
  route_info(@route)

  puts 'Введите номер промежуточной станции для её удаления из маршрута:'
  print '>> '
  station = @route.stations[gets.chomp.to_i - 1]
  @route.remove_station(station)
end