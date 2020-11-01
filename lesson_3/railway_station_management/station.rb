=begin
Класс Station (Станция):
+ Имеет название, которое указывается при ее создании
+ Может принимать поезда (по одному за раз)
+ Может возвращать список всех поездов на станции, находящиеся в текущий момент
+ Может возвращать список поездов на станции по типу (см. ниже): 
  кол-во грузовых, пассажирских
+ Может отправлять поезда (по одному за раз, при этом, 
  поезд удаляется из списка поездов, находящихся на станции).
=end

class Station
  attr_reader :trains # для возврата списка поездов на этой станции
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = [] 
  end

  # принятие поезда, добавляем поезд в список поездовб,
  # метод вызывается поездом
  def accept_train(train)
    @trains << train

    # передаем текущую станцию в поезд для запоминания
    train.current_station = self
  end

  # возврящает хеш поездов на странции с кол-м поездов каждого типа
  def trains_list_type
    trains_type_count = Hash.new(0)

    @trains.each do |train|
      trains_type_count[train.type] += 1
    end

    return trains_type_count
  end

  # отправляем поезд - удаляя поезд из списка станции
  # метод вызывается поездом
  def send_train(train)  
    @trains.delete(train)
  end
end