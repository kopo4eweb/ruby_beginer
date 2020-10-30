require './station.rb'
require './route.rb'
require './train.rb'

# Create Station
s_s = Station.new('Начальная')
s_1 = Station.new('Промежуточная 1')
s_2 = Station.new('Промежуточная 2')
s_3 = Station.new('Промежуточная 3')
s_4 = Station.new('Сортировочная')
s_e = Station.new('Конечная')

@all_stations = [s_s, s_e, s_1, s_2, s_3, s_4]

def trains_to_station
  puts 'Станции и поезда на них:'
  @all_stations.each do |station|
    print "  #{station.name}: "
    station.trains.each { |train| print "#{train.number}, " }
    print "\n    Сколько и какких типов поезда стоят на станции: #{station.trains_list_type}" if !station.trains_list_type.empty?
    print "\n"
  end
  puts '---------------------------'
end

# trains_to_station

# Create Route
puts 'Маршруты:'

r_1 = Route.new(s_s, s_e)
print '> маршрут 1: '
r_1.stations.each { |station| print "#{station.name}, " }
print "\n"

r_2 = Route.new(s_s, s_e)
r_2.add_station(s_1)
r_2.add_station(s_2)
r_2.add_station(s_3)
r_2.add_station(s_4)
print '> маршрут 2: '
r_2.stations.each { |station| print "#{station.name}, " }
print "\n"
puts "> удаляем промежуточную станцию: #{s_4.name}"
r_2.remove_station(s_4)
print '> скорректированный маршрут 2: '
r_2.stations.each { |station| print "#{station.name}, " }
print "\n"

r_3 = Route.new(s_e, s_s)
r_3.add_station(s_4)
print '> маршрут 3: '
r_3.stations.each { |station| print "#{station.name}, " }
print "\n"

puts '---------------------------'

# Create Train
t_1 = Train.new('Сапсан', 'passanger', 10)
t_2 = Train.new('Регулярный', 'passanger', 20)
t_3 = Train.new('Грузовой', 'cargo', 89)
t_4 = Train.new('МЕГА Грузовой', 'cargo', 250)

puts 'Поезда:'

puts "> #{t_1.number} [#{t_1.type}]"
t_1.set_route(r_1)

puts "> #{t_2.number} [#{t_2.type}]"
t_2.set_route(r_2)

puts "> #{t_3.number} [#{t_3.type}]"
t_3.set_route(r_1)

puts "> #{t_4.number} [#{t_4.type}]"
t_4.set_route(r_3)

puts '---------------------------'

trains_to_station

=begin 
Станции могут отправлять только те поезда которые на них находяться.
Ниже код в котором проверяются отправление стнациями поездов и попытка отправить позд которого на станции нет, так же провереряем, что поезд не может быть отправлен дальше конечной станции в маршруте. 
=end
puts "Станция #{s_s.name} отправляет поезда"
s_s.send_train(t_1)
s_s.send_train(t_2)
s_s.send_train(t_3)
s_s.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Станция #{s_e.name} отправляет поезда"
s_e.send_train(t_1)
s_e.send_train(t_2)
s_e.send_train(t_3)
s_e.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Станция #{s_1.name} отправляет поезда"
s_1.send_train(t_1)
s_1.send_train(t_2)
s_1.send_train(t_3)
s_1.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Станция #{s_2.name} отправляет поезда"
s_2.send_train(t_1)
s_2.send_train(t_2)
s_2.send_train(t_3)
s_2.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Станция #{s_3.name} отправляет поезда"
s_3.send_train(t_1)
s_3.send_train(t_2)
s_3.send_train(t_3)
s_3.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Станция #{s_4.name} отправляет поезда"
s_4.send_train(t_1)
s_4.send_train(t_2)
s_4.send_train(t_3)
s_4.send_train(t_4)
puts '---------------------------'

trains_to_station

puts "Поезд '#{t_4.number}' сам управляет своим передвежением от станции к станции"
puts "сменяет маршрут"
t_4.set_route(r_2)
puts "  на станции: #{t_4.current_station.name}"
puts "  текущая скорость: #{t_4.speed}"
t_4.speed = 22
puts "  текущая скорость: #{t_4.speed}"
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts '  отцепить 2 вагона'
t_4.remove_carriage
t_4.remove_carriage
puts "  кол-во вагонов: #{t_4.count_carriage}"
t_4.stop
puts '  отцепить 2 вагона'
t_4.remove_carriage
t_4.remove_carriage
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts "  начать путь к следующей станции: #{t_4.next_station.name}"
t_4.go_ahead
puts "  на станции: #{t_4.current_station.name}"
puts "  текущая скорость: #{t_4.speed}"
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts '  прицепить 3 вагона'
t_4.add_carriage
t_4.add_carriage
t_4.add_carriage
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts "  начать путь к следующей станции: #{t_4.next_station.name}"
t_4.go_ahead
puts "  на станции: #{t_4.current_station.name}"
puts "  начать путь к следующей станции: #{t_4.next_station.name}"
t_4.go_ahead
puts "  на станции: #{t_4.current_station.name}"
puts "  вернуться к предудущей станции: #{t_4.prev_station.name}"
t_4.go_back
puts "  на станции: #{t_4.current_station.name}"
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts '  прицепить 3 вагона'
t_4.add_carriage
t_4.add_carriage
t_4.add_carriage
puts "  кол-во вагонов: #{t_4.count_carriage}"
puts "  начать путь к следующей станции: #{t_4.next_station.name}"
t_4.go_ahead
puts "  на станции: #{t_4.current_station.name}"
puts "  начать путь к следующей станции: #{t_4.next_station.name}"
t_4.go_ahead
puts "  на станции: #{t_4.current_station.name}"
t_4.go_ahead
t_4.go_ahead
puts '---------------------------'

trains_to_station