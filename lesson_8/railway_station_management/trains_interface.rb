require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'train_interface'

class TrainsInterface
  def self.menu
    loop do
      puts "Поездов: Грз[#{CargoTrain.instances}], Пасж[#{PassengerTrain.instances}], без указания типа[#{Train.instances}]"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать поезд'

      if Interface.trains.size > 0
        puts '2 - Выбрать поезд, перейти к операциям с ним' 
        puts '3 - Найти поезд по его номеру'
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
          puts '--> Создать поезд'
          create()
        when 2
          puts '--> Выбрать поезд, операции с ним'        
          TrainInterface.menu(select())
        when 3
          puts '--> Найти поезд по его номеру'
          find()
      else
        puts '! Неизвестная операция'
      end
  
      puts "\n"
    end
  end

  def self.create
    begin
      puts 'Введите номер поезда:'
      print '>> '
      number = gets.chomp
    
      puts 'Выберите тип поезда:'
      puts '1 - Грузовой'
      puts '2 - Пассажирский'
      print '>> '
      type = gets.chomp.to_i

      puts 'Введите название производителя:'
      print '>> '
      company = gets.chomp.capitalize
      
      if type == 1
        train = CargoTrain.new(number)
        train.company = company
        Interface.trains << train
      elsif type == 2
        train = PassengerTrain.new(number)
        train.company = company
        Interface.trains << train
      else
        raise TypeError, 'Нет такого типа поезда'
      end
    rescue RegexpError => e
      puts "! Ошибка: #{e.message}"
      retry
    rescue TypeError => e
      puts "! Ошибка: #{e.message}"
      retry
    end

    puts "Добавлен поезд под номером: #{train.number}, тип: #{train.type}"
  end
  
  def self.list
    puts 'Список поездов:'
    Interface.trains.each_with_index { |train, index| puts "\t#{index + 1} - #{train.number} (#{train.company.nil? ? '-' : train.company})" }
  end
  
  def self.select
    list()
    
    begin
      puts 'Введите порядковый номер поезда:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Поезда под таким номером не существует' if index <= 0 || index > Interface.trains.length
      train = Interface.trains[index - 1]
      return train
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry
    end
  end

  def self.find
    puts 'Введите номер поезда:'
    print '>> '
    number = gets.chomp

    p Train.find(number)
  end
end