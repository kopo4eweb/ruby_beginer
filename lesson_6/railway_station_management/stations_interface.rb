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
      operation = -1 if operation !~ /^\d*$/
  
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
    begin 
      puts 'Введите название станции:'
      print '>> '
      Interface.stations << Station.new(gets.chomp.capitalize)
    rescue RegexpError => e
      puts "! Ошибка: #{e.message}"
      retry
    end

    puts "Создана станция: #{Interface.stations.last.name}"
  end

  def self.show_stations
    Station.all().each_with_index { |station, index| puts "\t#{index + 1} - #{station.name}" }
  end

  def self.info
    show_stations()
    
    begin
      puts "Введите номер станции:"
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Станции с таким номером не существует' if index <= 0 || index > Interface.stations.length
      station = Interface.stations[index - 1]
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry 
    end
    
    print "\t#{station.name}: \n\t"
    station.trains.each { |train| print "#{train.number}, " }
    puts "\n\tСколько и каких типов поезда стоят на станции: #{station.trains_list_type}" if !station.trains_list_type.empty?  
  end
end