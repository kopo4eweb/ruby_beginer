require_relative 'route'
require_relative 'route_interface'

class RoutesInterface
  def self.menu
    loop do
      puts "Маршрутов: #{Route.instances}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Создать маршрут'
  
      if Interface.routes.size > 0
        puts '2 - Список всех маршрутов'
        puts '3 - Выбрать маршрут, перейти к операциям с ним'
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
          puts '--> Создать маршрут'
          create()
        when 2
          puts '--> Список всех маршрутов'
          show_routes()
        when 3
          puts '--> Выбрать маршрут, оперции с ним'
          RouteInterface.menu(select())
      else
        puts '! Неизвестная операция'
      end
  
      puts "\n"
    end
  end

  def self.create
    StationsInterface.show_stations() # показать все станции что есть

    begin
      puts 'Введите номер начальной станции:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Станции с таким номером не существует' if index <= 0 || index > Interface.stations.length
      first = Interface.stations[index - 1]
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry 
    end
      
    begin
      puts 'Введите номер конечной станции:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Станции с таким номером не существует' if index <= 0 || index > Interface.stations.length
      last = Interface.stations[index - 1]
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry 
    end
  
    Interface.routes << Route.new(first, last)
  end
  
  def self.show_routes
    Interface.routes.each_with_index do |route, index| 
      puts "\t[#{index + 1}] маршрут:" 
      RouteInterface.info(route)
    end
  end
  
  def self.select
    show_routes()

    begin
      puts 'Введите номер маршрута:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Маршрута с таким номером не существует' if index <= 0 || index > Interface.routes.length
      return Interface.routes[index - 1]
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry
    end
  end
end