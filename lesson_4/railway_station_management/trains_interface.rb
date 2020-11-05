require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'train_interface'

class TrainsInterface
  def self.menu
    loop do
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать поезд'
      puts '2 - Выбрать поезд, перейти к операциям с ним' if Interface.trains.size > 0
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
          create()
        when 2
          puts '--> Выбрать поезд, операции с ним'        
          TrainInterface.menu(select())
      else
        puts '! Неизвестная операция'
      end
  
      puts "\n"
    end
  end

  def self.create
    puts 'Введите номер поезда:'
    print '>> '
    number = gets.chomp
  
    puts 'Выберите тип поезда:'
    puts '1 - Грузовой'
    puts '2 - Пассажирский'
    print '>> '
    type = gets.chomp.to_i
    
    if type == 1
      Interface.trains << CargoTrain.new(number)
    elsif type == 2
      Interface.trains << PassengerTrain.new(number)
    else
      puts '! нет такого типа поезда'
    end
  end
  
  def self.list
    puts 'Список поездов:'
    Interface.trains.each_with_index { |train, index| puts "\t#{index + 1} - #{train.number}" }
  end
  
  def self.select
    list()
  
    puts 'Введите номер поезда:'
    print '>> '
    train = Interface.trains[gets.chomp.to_i - 1]
    return puts '! Поезда под таким номером не существует' if train.nil?
    return train
  end
end