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
      operation = -1 if operation.empty?
  
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
  
    puts 'Введите номер начальной станции:'
    print '>> '
    first = Interface.stations[gets.chomp.to_i - 1]
    return puts '! Станции под таким номером не существует' if first.nil?
  
    puts 'Введите номер конечной станции:'
    print '>> '
    last = Interface.stations[gets.chomp.to_i - 1]
    return puts '! Станции под таким номером не существует' if last.nil?
  
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
  
    puts 'Введите номер маршрута:'
    print '>> '
    route = Interface.routes[gets.chomp.to_i - 1]
    return puts '! Маршрута под таким номером не существует' if route.nil?
    return route
  end
end