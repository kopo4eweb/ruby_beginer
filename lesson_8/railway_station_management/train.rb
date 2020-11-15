require_relative 'types'
require_relative 'company'
require_relative 'instance_counter'

class Train
  include Company
  include InstanceCounter

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i

  attr_reader :number
  attr_accessor :speed
  attr_accessor :current_station
  attr_reader :carriages, :type

  @@trains = []

  def self.find(number)
    @@trains.each { |train| return train if number == train.number }
    return
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @carriages = []
    @speed = 0
    @route = nil
    @current_station_position = 0
    @current_station = nil
    @@trains << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  # написать метод, который принимает блок и проходит по всем вагонам 
  # поезда (вагоны должны быть во внутреннем массиве), 
  # передавая каждый объект вагона в блок.
  def get_carriages(&block)
    if block_given?
      @carriages.each_with_index do |carriage, index| 
        yield(carriage, index + 1)
      end
    end
  end

  # тормозить
  def stop
    @speed = 0
  end

  # прицеплять вагон
  def add_carriage(carriade)
    @carriages << carriade
  end
  
  # отцеплять вагон
  def remove_carriage(index)
    @carriages.delete_at(index)
  end

  # назначение маршрута поезду
  def set_route(route)
    @route = route

    # устанавливаем текущую позицию поезда на первой станции в маршруте
    @current_station_position = 0

    # добавиться в список поездов на станции
    add_train_to_station_list
  end

  # поезд движется вперед
  def go_ahead
    # увеличиваем позицию для перемещения по маршруту
    @current_station_position += 1
    
    remove_train_from_station_list
    add_train_to_station_list
  end

  # поезд движется назад
  def go_back
    # уменьшаем позицию для перемещения по маршруту
    @current_station_position -= 1

    remove_train_from_station_list
    add_train_to_station_list
  end

  # возвращаем предыдущую станцию
  def prev_station
    if @current_station_position > 0
      @route.stations[@current_station_position - 1]
    end
  end

  # возвращаем следующую станцию
  def next_station
    if @current_station_position < @route.stations.length
      @route.stations[@current_station_position + 1]
    end
  end

  # эти методы вызываются только в методах внутри оъекта, 
  # они не должны вызываться из вне объекта
  # они не переназначаются в дочерних классах, поэтому они 
  # сделаны private а не protected
  private

  def validate!
    raise(
      RegexpError, 
      'Допустимый формат: три буквы или цифры в любом порядке, ' \
      'необязательный дефис (может быть, а может нет) и еще 2 ' \
      'буквы или цифры после дефиса.' 
      ) if @number !~ NUMBER_FORMAT
    raise TypeError, 'Нет такого типа поезда' unless TYPE.key?(@type)
  end

  # занесение поезда в список поездов станции
  def add_train_to_station_list
    @route.stations[@current_station_position].accept_train(self)
  end

  # удаление поезда из списка поездов станции
  def remove_train_from_station_list
    @current_station.send_train(self)
  end
end