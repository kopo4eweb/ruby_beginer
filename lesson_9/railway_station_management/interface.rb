# frozen_string_literal: true

require_relative 'error'
require_relative 'templates'
require_relative 'stations_interface'
require_relative 'routes_interface'
require_relative 'trains_interface'
# require_relative 'seeds'

# main interface class
class Interface
  @trains = []
  @routes = []
  @stations = []

  class << self
    attr_accessor :trains, :routes, :stations

    def selectable_operations
      puts 'Введите цифру - выберите действие:'
      puts '1 - Станции'
      puts '2 - Маршруты'
      puts '3 - Поезда'
      puts '0 - Выйти из приложения'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
      operation.to_i
    end

    def menu
      puts '< << Симулятор управления ЖД станциями >> >'

      # Seeds.init

      loop do
        operation = selectable_operations

        puts "\n"

        case operation
        when 0
          break
        when 1
          puts '--> Операции со станциями'
          StationsInterface.menu
        when 2
          puts '--> Оперции с маршрутами'
          RoutesInterface.menu
        when 3
          puts '--> Оперции с поездами'
          TrainsInterface.menu
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end
  end
end
