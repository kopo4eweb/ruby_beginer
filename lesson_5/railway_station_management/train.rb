require_relative 'types'

class Train
  attr_reader :number # возвращать номер поезда
  attr_accessor :speed # задавать / возвращать скорость
  attr_accessor :current_station # возвращать / задание текущей станции из объекта станции
  attr_reader :carriages, :type

  def initialize(number, type)
    @number = number
    @type = type
    @carriages = []
    @speed = 0
    @route = nil
    @current_station_position = 0
    @current_station = nil
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
  def remove_carriage
    @carriages.pop
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
    @route.stations[@current_station_position - 1] if @current_station_position > 0
  end

  # возвращаем следующую станцию
  def next_station
    @route.stations[@current_station_position + 1] if @current_station_position < @route.stations.length
  end

  # эти методы вызываются только в методах внутри оъекта, они не должны вызываться из вне объекта
  # они не переназначаются в дочерних классах, поэтому они сделаны private а не protected
  private
    # занесение поезда в список поездов станции
    def add_train_to_station_list
      @route.stations[@current_station_position].accept_train(self)
    end

    # удаление поезда из списка поездов станции
    def remove_train_from_station_list
      @current_station.send_train(self)
    end
end