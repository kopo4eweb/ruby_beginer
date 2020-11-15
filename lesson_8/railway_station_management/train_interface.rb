require_relative 'carriage_interface'

class TrainInterface
  def self.menu(train)
    return if train.nil?

    @@train = train

    loop do
      puts "Выбран поезд: #{@@train.number} [#{@@train.type}]"
      puts 'Введите цифру - выберите действие:'    
      puts '1 - Назначить маршрут поезду'
      
      if !@@train.current_station.nil?
        puts '2 - Операции с вагонами'
        puts '3 - Текущая станция'
        puts '4 - Двигаться вперед'
        puts '5 - Двигаться назад'
        puts '6 - Скорость поезда'
        puts '7 - Задать скорость поезду'
        puts '8 - Остановить поезд'
        puts '9 - Проверить на валидность'
      end

      puts '0 - Вернуться в меню поездов'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/

      puts "\n"

      case operation.to_i
        when 0
          break
        when 1
          puts '--> Назначить маршрут поезду'
          set_route()
        when 2
          puts '--> Операции с вагонами'
          CarriageInterface.menu(@@train)
        when 3
          puts '--> Поезд находится на станции'
          puts "\t#{@@train.current_station.name}"
        when 4
          puts '--> Двигаться вперед'
          go_ahead()
        when 5
          puts '--> Двигаться назад'
          go_back()
        when 6
          puts '--> Скорость поезда'
          puts "\t#{@@train.speed}"
        when 7
          puts '--> Задать скорость поезду'
          set_speed()
        when 8
          puts '--> Остановить поезд'
          @@train.stop()
        when 9
          puts '--> Проверить на валидность'
          puts "\tДанные поезда #{@@train.valid? ? 'валидны' : 'не валидны'}"
      else
        puts '! Неизвестная операция'
      end

      puts "\n"
    end
  end

  def self.set_route
    RoutesInterface.show_routes()

    begin
      puts 'Введите номер маршрута:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Маршрута с таким номером не существует!' if index <= 0 || index > Interface.routes.length
      route = Interface.routes[index - 1]
      @@train.set_route(route)
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry
    end
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