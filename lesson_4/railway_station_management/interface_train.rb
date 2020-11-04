require './cargo_carriage.rb'
require './passenger_carriage.rb'

@train = nil

def train(train)
  return if train.nil?

  @train = train

  loop do
    puts "Выбран поезд: #{@train.number} [#{@train.type}]"
    puts 'Введите цифру - выберите действие:'    
    puts '1 - Назначить маршрут поезду'
    
    if !@train.current_station.nil?
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
        train_set_route()
      when 2
        puts '--> Прицепить вагоны к поезду'
        train_add_carriage()
        puts "\tВсего вагонов: #{@train.carriages.size}"
      when 3
        puts '--> Отцепить вагоны от поезда'
        train_remove_carriage()
        puts "\tВсего вагонов: #{@train.carriages.size}"
      when 4
        puts '--> Поезд находится на станции'
        puts "\t#{@train.current_station.name}"
      when 5
        puts '--> Двигаться вперед'
        @train.go_ahead()
        puts "\tПоезд на странции: #{@train.current_station.name}"
      when 6
        puts '--> Двигаться назад'
        @train.go_back()
        puts "\tПоезд на странции: #{@train.current_station.name}"
      when 7
        puts '--> Скорость поезда'
        puts "\t#{@train.speed()}"
      when 8
        puts '--> Задать скорость поезду'
        train_set_speed()
      when 9
        puts '--> Остановить поезд'
        @train.stop()
    else
      puts '! Неизвестная операция'
    end

    puts "\n"
  end
end

def train_set_route
  show_routes()

  puts 'Введите номер маршрута:'
  print '>> '
  route = @routes[gets.chomp.to_i - 1]  
  return puts '! Маршрута под таким номером не существует' if route.nil?
  @train.set_route(route)
end

def train_add_carriage
  puts 'Введите кол-во вагонов:'
  print '>> '
  count = gets.chomp.to_i

  puts 'Выберите тип вагонов:'
  puts '1 - Грузовые'
  puts '2 - Пассажирские'
  print '>> '
  type = gets.chomp.to_i

  if type == 1
    count.times { @train.add_carriage(CargoCarriage.new()) }
  elsif type == 2
    count.times { @train.add_carriage(PassengerCarriage.new()) }
  else
    puts '! нет такого типа вагонов'
  end
end

def train_remove_carriage
  puts 'Введите кол-во вагонов:'
  print '>> '
  count = gets.chomp.to_i
  count.times { @train.remove_carriage() }
end

def train_set_speed
  puts 'Введите скорость:'
  print '>> '
  @train.speed = gets.chomp.to_i
end