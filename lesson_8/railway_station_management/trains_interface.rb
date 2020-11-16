# frozen_string_literal: true

require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'train_interface'

# interface for control trains
class TrainsInterface
  class << self
    def selectable_operations
      puts "Поездов: Грз[#{CargoTrain.instances}], " \
        "Пасж[#{PassengerTrain.instances}], " \
        "без указания типа[#{Train.instances}]"

      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать поезд'

      if Interface.trains.size.positive?
        puts '2 - Выбрать поезд, перейти к операциям с ним'
        puts '3 - Найти поезд по его номеру'
      end

      puts '0 - Вернуться в главное меню'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
      operation.to_i
    end

    def menu
      loop do
        operation = selectable_operations

        puts "\n"

        case operation
        when 0
          break
        when 1
          puts '--> Создать поезд'
          create
        when 2
          puts '--> Выбрать поезд, операции с ним'
          TrainInterface.menu(select)
        when 3
          puts '--> Найти поезд по его номеру'
          find
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end

    def create
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

        case type
        when 1
          train = CargoTrain.new(number)
          train.company = company
          Interface.trains << train
        when 2
          train = PassengerTrain.new(number)
          train.company = company
          Interface.trains << train
        else
          raise ArgumentError, 'Нет такого типа поезда'
        end
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end

      puts "Добавлен поезд под номером: #{train.number}, тип: #{train.type}"
    end

    def list
      puts 'Список поездов:'
      Interface.trains.each_with_index do |train, index|
        puts "\t#{index + 1} - #{train.number} " \
        "(#{train.company.nil? ? '-' : train.company})"
      end
    end

    def select
      list

      begin
        puts 'Введите порядковый номер поезда:'
        print '>> '
        index = gets.chomp.to_i

        error_message = 'Поезда под таким номером не существует'
        raise ArgumentError, error_message if index <= 0 || index > Interface.trains.length

        Interface.trains[index - 1]
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end
    end

    def find
      puts 'Введите номер поезда:'
      print '>> '
      number = gets.chomp

      p Train.find(number)
    end
  end
end
