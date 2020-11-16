# frozen_string_literal: true

require_relative 'route'
require_relative 'route_interface'

# interface for control routes
class RoutesInterface
  class << self
    def selectable_operations
      puts "Маршрутов: #{Route.instances}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать маршрут'

      if Interface.routes.size.positive?
        puts '2 - Список всех маршрутов'
        puts '3 - Выбрать маршрут, перейти к операциям с ним'
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
          puts '--> Создать маршрут'
          create
        when 2
          puts '--> Список всех маршрутов'
          show_routes
        when 3
          puts '--> Выбрать маршрут, оперции с ним'
          RouteInterface.menu(select)
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end

    def select_station(title)
      puts title
      print '>> '
      index = gets.chomp.to_i

      error_message = 'Станции с таким номером не существует'
      raise ArgumentError, error_message if index <= 0 || index > Interface.stations.length

      yield(index - 1)
    rescue ArgumentError => e
      Error.show_message(e.message)
      retry
    end

    def create
      StationsInterface.show_stations

      first = nil
      last = nil

      select_station(
        'Введите порядковый номер начальной станции:'
      ) { |index| first = Interface.stations[index] }

      select_station(
        'Введите порядковый номер конечной станции:'
      ) { |index| last = Interface.stations[index] }

      Interface.routes << Route.new(first, last)
    end

    def show_routes
      Interface.routes.each_with_index do |route, index|
        puts "\t[#{index + 1}] маршрут:"
        RouteInterface.info(route)
      end
    end

    def select
      show_routes

      begin
        puts 'Введите порядковый номер маршрута:'
        print '>> '
        index = gets.chomp.to_i

        error_message = 'Маршрута с таким номером не существует'
        raise ArgumentError, error_message if index <= 0 || index > Interface.routes.length

        Interface.routes[index - 1]
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end
    end
  end
end
