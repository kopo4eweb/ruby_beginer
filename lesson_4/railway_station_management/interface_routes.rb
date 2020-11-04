require_relative './route.rb'
require_relative './interface_route.rb'

@routes = []

def routes
  loop do
    puts 'Введите цифру - выберите действие:'
    puts '1 - Создать маршрут'

    if @routes.size > 0
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
        create_route()
      when 2
        puts '--> Список всех маршрутов'
        show_routes()
      when 3
        puts '--> Выбрать маршрут, оперции с ним'
        route(select_route())
    else
      puts '! Неизвестная операция'
    end

    puts "\n"
  end
end

def create_route
  show_stations() # показать все станции что есть

  puts 'Введите номер начальной станции:'
  print '>> '
  first = @stations[gets.chomp.to_i - 1]

  puts 'Введите номер конечной станции:'
  print '>> '
  last = @stations[gets.chomp.to_i - 1]

  @routes << Route.new(first, last)
end

def show_routes
  @routes.each_with_index do |route, index| 
    puts "\t[#{index + 1}] маршрут:" 
    route_info(route)
  end
end

def select_route
  show_routes()

  puts 'Введите номер маршрута:'
  print '>> '
  route = @routes[gets.chomp.to_i - 1]
  return puts '! Маршрута под таким номером не существует' if route.nil?
  return route
end