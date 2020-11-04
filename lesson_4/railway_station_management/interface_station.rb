require_relative './station.rb'

@stations = []

def stations
  loop do
    puts 'Введите цифру - выберите действие:'
    puts '1 - Создать станцию'

    if @stations.size > 0
      puts '2 - Список всех станций'
      puts '3 - Список поездов на станции'
    end

    puts '0 - Вернуться в главное меню'
    print '>> '

    operation = gets.chomp
    operation = -1 if operation.empty?

    puts "\n"

    case operation.to_i
      when 0
        break
      when 1
        puts '--> Создать станцию'
        create_station()
      when 2
        puts '--> Список всех станцый'
        show_stations()
      when 3
        puts '--> Информация по станции'
        station_info()
    else
      puts '! Неизвестная операция'
    end

    puts "\n"
  end
end

def create_station  
  puts 'Введите название станции:'
  print '>> '
  @stations << Station.new(gets.chomp.capitalize)
end

def show_stations
  @stations.each_with_index { |station, index| puts "\t#{index + 1} - #{station.name}" }
end

def station_info
  puts "Введите номер станции, число от 1 до #{@stations.size}"
  print '>> '
  station = @stations[gets.chomp.to_i - 1]
  
  if !station.nil?
    print "\t#{station.name}: \n\t"
    station.trains.each { |train| print "#{train.number}, " }
    puts "\n\tСколько и каких типов поезда стоят на станции: #{station.trains_list_type}" if !station.trains_list_type.empty?
  else
    puts "\t ! Станции с таким номером не существует!"
  end
end