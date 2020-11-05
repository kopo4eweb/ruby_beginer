require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class TrainInterface
  def self.menu(train)
    return if train.nil?

    @@train = train

    loop do
      puts "Выбран поезд: #{@@train.number} [#{@@train.type}]"
      puts 'Введите цифру - выберите действие:'    
      puts '1 - Назначить маршрут поезду'
      
      if !@@train.current_station.nil?
        puts '2 - Прицепить вагоны к поезду'
        puts '3 - Отцепить вагоны от поезда'    
        puts '4 - Текущая станция' 
        puts '5 - Двигаться вперед' 
        puts '6 - Двигаться назад'    
        puts '7 - Скорость поезда'
        puts '8 - Задать скорость поезду'
        puts '9 - Остановить поезд'    
      end

      puts '0 - Вернуться в меню поездов'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation.empty?

      puts "\n"

      case operation.to_i
        when 0
          break
        when 1
          puts '--> Назначить маршрут поезду'
          set_route()
        when 2
          puts '--> Прицепить вагоны к поезду'
          add_carriage()
        when 3
          puts '--> Отцепить вагоны от поезда'
          remove_carriage()
        when 4
          puts '--> Поезд находится на станции'
          puts "\t#{@@train.current_station.name}"
        when 5
          puts '--> Двигаться вперед'
          go_ahead()
        when 6
          puts '--> Двигаться назад'
          go_back()
        when 7
          puts '--> Скорость поезда'
          puts "\t#{@@train.speed()}"
        when 8
          puts '--> Задать скорость поезду'
          set_speed()
        when 9
          puts '--> Остановить поезд'
          @@train.stop()
      else
        puts '! Неизвестная операция'
      end

      puts "\n"
    end
  end

  def self.set_route
    RoutesInterface.show_routes()
  
    puts 'Введите номер маршрута:'
    print '>> '
    route = Interface.routes[gets.chomp.to_i - 1]  
    return puts '! Маршрута под таким номером не существует' if route.nil?
    @@train.set_route(route)
  end
  
  def self.add_carriage
    return puts '! Остановите сначала поезд' if @@train.speed > 0

    puts 'Введите кол-во вагонов:'
    print '>> '
    count = gets.chomp.to_i
  
    puts 'Выберите тип вагонов:'
    puts '1 - Грузовые'
    puts '2 - Пассажирские'
    print '>> '
    type = gets.chomp.to_i

    if !TYPE.to_a[type - 1].nil?
      return puts "! К поезду типа '#{@@train.type}' можно прицеплять вагоны только того же типа" if TYPE.to_a[type - 1][0] != @@train.type
    end
  
    if type == 1
      count.times { @@train.add_carriage(CargoCarriage.new()) }
    elsif type == 2
      count.times { @@train.add_carriage(PassengerCarriage.new()) }
    else
      puts '! нет такого типа вагонов'
    end

    puts "\tВсего вагонов: #{@@train.carriages.size}"
  end
  
  def self.remove_carriage
    return puts '! Остановите сначала поезд' if @@train.speed > 0

    puts 'Введите кол-во вагонов:'
    print '>> '
    count = gets.chomp.to_i

    if count > @@train.carriages.size
      puts "! К поезду прицеплено только #{@@train.carriages.size}, столько и будет отцеплено"
      count = @@train.carriages.size
    end

    count.times { @@train.remove_carriage() }

    puts "\tВсего вагонов: #{@@train.carriages.size}"
  end

  def self.go_ahead
    return puts "! Поезд '#{@@train.number}' на конечной станции: #{@@train.current_station.name}" if @@train.next_station.nil?
    @@train.go_ahead()
    puts "\tПоезд прибыл на странцию: #{@@train.current_station.name}"
  end

  def self.go_back
    return puts "! Поезд '#{@@train.number}' на начальной станции: #{@@train.current_station.name}" if @@train.prev_station.nil?
    @@train.go_back()
    puts "\tПоезд прибыл на странцию: #{@@train.current_station.name}"
  end
  
  def self.set_speed
    puts 'Введите скорость:'
    print '>> '
    @@train.speed = gets.chomp.to_i
  end
end