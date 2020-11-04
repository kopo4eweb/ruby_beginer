require './cargo_train.rb'
require './passenger_train.rb'
require './interface_train.rb'

@trains = []

def trains
  loop do
    puts 'Введите цифру - выберите действие:'
    puts '1 - Создать поезд'
    puts '2 - Выбрать поезд, перейти к операциям с ним' if @trains.size > 0
    puts '0 - Вернуться в главное меню'
    print '>> '

    operation = gets.chomp
    operation = -1 if operation.empty?

    puts "\n"

    case operation.to_i
      when 0
        break
      when 1
        puts '--> Создать поезд'
        create_train()
      when 2
        puts '--> Выбрать поезд, операции с ним'        
        train(select_train())
    else
      puts '! Неизвестная операция'
    end

    puts "\n"
  end
end

def create_train
  puts 'Введите номер поезда:'
  print '>> '
  number = gets.chomp

  puts 'Выберите тип поезда:'
  puts '1 - Грузовой'
  puts '2 - Пассажирский'
  print '>> '
  type = gets.chomp.to_i
  
  if type == 1
    @trains << CargoTrain.new(number)
  elsif type == 2
    @trains << PassengerTrain.new(number)
  else
    puts '! нет такого типа поезда'
  end
end

def list_trains
  puts 'Список поездов:'
  @trains.each_with_index { |train, index| puts "\t#{index + 1} - #{train.number}" }
end

def select_train
  list_trains()

  puts 'Введите номер поезда:'
  print '>> '
  train = @trains[gets.chomp.to_i - 1]
  return puts '! Поезда под таким номером не существует' if train.nil?
  return train
end