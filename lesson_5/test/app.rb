require './station.rb'
require './cargo_train.rb'
require './passenger_train.rb'
require './cargo_carriage.rb'
require './passenger_carriage.rb'

# stations
s1 = Station.new('st. One')
s2 = Station.new('st. Two')
s3 = Station.new('st. Three')
s4 = Station.new('st. Four')

p Station.all

p Station.instances

puts '-----------trains-----------'

#trains
tc1 = CargoTrain.new('МЕГА грузовой')
tc2 = CargoTrain.new('МЕГА')
tc3 = CargoTrain.new('cargo')
tp1 = PassengerTrain.new('Сапсан - коженные мешки')
tp2 = PassengerTrain.new('Pass')

p CargoTrain.instances
p PassengerTrain.instances
p Train.instances

tc1.company = 'Simens'
p tc1
p tc1.company

puts '----------------------'

p tc2.company

puts '----------------------'

p Train.find('МЕГА')
p Train.find('МЕГА2')
p Train.find('Pass')
p Train.find('Сапсан - коженные мешки')
p Train.find(nil)

puts '-----------carriages-----------'

cg1 = CargoCarriage.new
cg2 = CargoCarriage.new
cp1 = PassengerCarriage.new
cp2 = PassengerCarriage.new

cg2.company = 'Hummer'

p cg1
p cg2
p cp1.company

puts '----------route------------'