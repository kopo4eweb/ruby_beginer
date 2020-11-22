# frozen_string_literal: true

require_relative 'station'

# interface for control stantions
class StationsInterface
  class << self
    def selectable_operations
      puts "Станций: #{Station.instances}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать станцию'

      if Interface.stations.size.positive?
        puts '2 - Список всех станций'
        puts '3 - Список поездов на станциях'
        puts '4 - Провалидировать все станции'
        puts '5 - Переименовать станцию'
      end

      puts '0 - Вернуться в главное меню'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
      operation.to_i
    end

    # rubocop:disable Metrics/CyclomaticComplexity, Metrics/BlockLength
    def menu
      loop do
        operation = selectable_operations

        puts "\n"

        case operation
        when 0
          break
        when 1
          puts '--> Создать станцию'
          create
        when 2
          puts '--> Список всех станцый'
          show_stations
        when 3
          puts '--> Информация по станциям'
          info
        when 4
          puts '--> Валидация всех станций'
          Interface.stations.each do |station|
            puts "Станция: #{station.name} -> #{station.valid? ? 'валидна' : 'не валинда'}"
          end
        when 5
          puts '--> Переименовать станцию'
          rename
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end
    # rubocop:enable Metrics/CyclomaticComplexity, Metrics/BlockLength

    def create
      begin
        puts 'Введите название станции:'
        print '>> '
        Interface.stations << Station.new(gets.chomp.capitalize)
      rescue StandardError => e
        Error.show_message(e.message)
        retry
      end

      puts "Создана станция: #{Interface.stations.last.name}"
    end

    def show_stations
      Station.all.each_with_index do |station, index|
        puts "\t#{index + 1} - #{station.name}"
      end
    end

    def info
      Interface.stations.each do |station|
        puts "Станция: #{station.name}"
        station.get_trains do |train|
          puts "\tПоезд: #{train.number}, тип: #{train.type}, " \
          "прицеплено вагонов: #{train.carriages.size}"
          Templates.show_carriage(train)
        end
      end
    end

    def rename
      show_stations

      station = nil
      RoutesInterface.select_station(
        'Введите порядковый номер станции:'
      ) { |index| station = Interface.stations[index] }

      begin
        puts "Введите новое название '#{station.name}' для станции"
        print '>> '
        name = gets.chomp

        station.name = name
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end
    end
  end
end
