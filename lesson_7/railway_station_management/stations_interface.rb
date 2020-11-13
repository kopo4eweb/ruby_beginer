require_relative 'station'

class StationsInterface
  def self.menu
    loop do
      puts "Станций: #{Station.instances}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать станцию'
  
      if Interface.stations.size > 0
        puts '2 - Список всех станций'
        puts '3 - Список поездов на станциях'
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
          puts '--> Информация по станциям'
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
    Interface.stations.each do |station|
      puts "Станция: #{station.name}"
      station.get_trains do |train| 
        puts "\tПоезд: #{train.number}, тип: #{train.type}, прицеплено вагонов: #{train.carriages.size}"
        Templates.show_carriage(train)
      end
    end
  end
end