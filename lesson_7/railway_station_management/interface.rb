require_relative 'templates'
require_relative 'stations_interface'
require_relative 'routes_interface'
require_relative 'trains_interface'

# require_relative 'seeds' # предустанвленный набор

class Interface
  @@trains = []
  @@routes = []
  @@stations = []

  def self.menu
    puts '< << Симулятор управления ЖД станциями >> >'

    # Seeds.init() # предустанвленный набор

    loop do
      puts 'Введите цифру - выберите действие:'
      puts '1 - Станции'
      puts '2 - Маршруты'
      puts '3 - Поезда'
      puts '0 - Выйти из приложения'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/

      puts "\n"

      case operation.to_i
        when 0
          break
        when 1
          puts '--> Операции со станциями'
          StationsInterface.menu()
        when 2
          puts '--> Оперции с маршрутами'
          RoutesInterface.menu()
        when 3
          puts '--> Оперции с поездами'
          TrainsInterface.menu()
      else
        puts '! Неизвестная операция'
      end

      puts "\n"
    end
  end

  def self.stations
    @@stations
  end

  def self.routes
    @@routes
  end

  def self.trains
    @@trains
  end
end