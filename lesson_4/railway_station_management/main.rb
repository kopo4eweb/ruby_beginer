require './interface_station.rb'
require './interface_routes.rb'
require './interface_trains.rb'

# require './seeds.rb'

puts '< << Симулятор управления ЖД станциями >> >'

loop do
  puts 'Введите цифру - выберите действие:'
  puts '1 - Станции'
  puts '2 - Маршруты'
  puts '3 - Поезда'
  puts '0 - Выйти из приложения'
  print '>> '

  operation = gets.chomp
  operation = -1 if operation.empty?

  puts "\n"

  case operation.to_i
    when 0
      break
    when 1
      puts '--> Операции со станциями'
      stations()
    when 2
      puts '--> Оперции с маршрутами'
      routes()
    when 3
      puts '--> Оперции с поездами'
      trains()
  else
    puts '! Неизвестная операция'
  end

  puts "\n"
end
