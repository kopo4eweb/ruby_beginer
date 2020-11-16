# frozen_string_literal: true

# interface for control route
class RouteInterface
  class << self
    def selectable_operations
      puts 'Введите цифру - выберите действие:'
      puts '1 - Список станций на маршруте'
      puts '2 - Добавить станцию на маршрут'
      puts '3 - Удалить станцию с маршрута'
      puts '0 - Вернуться в меню маршрутов'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
      operation.to_i
    end

    def menu(route)
      return if route.nil?

      @route = route

      loop do
        operation = selectable_operations

        puts "\n"

        case operation
        when 0
          break
        when 1
          puts '--> Список станций на маршруте'
          info(@route)
        when 2
          puts '--> Добавить станцию на маршрут'
          add_station
        when 3
          puts '--> Удалить станцию с маршрута'
          remove_station
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end

    def info(route)
      route.stations.each_with_index do |station, index|
        puts "\t#{index + 1} - #{station.name}"
      end
    end

    def select(title, obj)
      puts title
      print '>> '
      index = gets.chomp.to_i

      error_message = 'Станции с таким номером не существует'
      raise ArgumentError, error_message if index <= 0 || index > obj.length

      station = obj[index - 1]
      yield(station)
    rescue ArgumentError => e
      Error.show_message(e.message)
      retry
    end

    def add_station
      StationsInterface.show_stations

      select(
        'Введите порядковый номер станции для добавления её в маршрут:',
        Interface.stations
      ) { |station| @route.add_station(station) }
    end

    def remove_station
      info(@route)

      select(
        'Введите порядковый номер промежуточной станции для её удаления ' \
        'из маршрута:',
        @route.stations
      ) { |station| @route.remove_station(station) }
    end
  end
end
