require_relative 'station'

class StationsInterface
  def self.menu
    loop do
      puts "Станций: #{Station.instances}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать станцию'
  
      if Interface.stations.size > 0
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
          create()
        when 2
          puts '--> Список всех станцый'
          show_stations()
        when 3
          puts '--> Информация по станции'
          info()
      else
        puts '! Неизвестная операция'
      end
  
      puts "\n"
    end
  end

  def self.create 
    puts 'Введите название станции:'
    print '>> '
    Interface.stations << Station.new(gets.chomp.capitalize)
  end

  def self.show_stations
    Station.all().each_with_index { |station, index| puts "\t#{index + 1} - #{station.name}" }
    # Interface.stations.each_with_index { |station, index| puts "\t#{index + 1} - #{station.name}" }
  end

  def self.info
    show_stations()
    
    puts "Введите номер станции:"
    print '>> '
    station = Interface.stations[gets.chomp.to_i - 1]
    return puts "\t ! Станции с таким номером не существует!" if station.nil?
    
    print "\t#{station.name}: \n\t"
    station.trains.each { |train| print "#{train.number}, " }
    puts "\n\tСколько и каких типов поезда стоят на станции: #{station.trains_list_type}" if !station.trains_list_type.empty?  
  end
end