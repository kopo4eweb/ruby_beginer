=begin
Класс Train (Поезд):
+ Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, 
  эти данные указываются при создании экземпляра класса
+ Может набирать скорость
+ Может возвращать текущую скорость
+ Может тормозить (сбрасывать скорость до нуля)
+ Может возвращать количество вагонов
+ Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает 
  или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
+ Может принимать маршрут следования (объект класса Route). 
+ При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
+ Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, 
  но только на 1 станцию за раз.
+ Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

class Train
  attr_reader :number # возвращать номер поезда
  attr_reader :count_carriage # возвращать кол-во вагонов
  attr_accessor :speed # задавать / возвращать скорость
  attr_reader :type # возвращать тип поезда для подсчета типов поездов
  attr_accessor :current_station # возвращать / задание текущей станции из объекта станции

  def initialize(number, type, count_carriage)
    @number = number
    @type = type.to_sym
    @count_carriage = count_carriage
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
  def add_carriage
    return puts 'Остановите сначала поезд' if speed > 0
    @count_carriage += 1
  end
  
  # отцеплять вагон
  def remove_carriage
    return puts 'Остановите сначала поезд' if speed > 0
    @count_carriage -= 1
  end

  # назначение маршрута поезду
  def set_route(route)
    @route = route

    # устанавливаем текущую позицию поезда на первой станции в маршруте
    @current_station_position = 0

    # добавиться в список поездов на станции
    add_train_to_station_list
  end

  # этот метод вызывает странция из которой отправляется поезд
  # поезд движется вперед
  def go_ahead
    return puts 'Вы на конечной станции' if next_station.nil?

    # увеличиваем позицию для перемещения по маршруту
    @current_station_position += 1
    
    remove_train_from_station_list
    add_train_to_station_list
  end

  # поезд движется назад
  def go_back
    return puts 'Вы на начальной станции' if prev_station.nil?

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

  private
    # занесение поезда в список поездов станции
    def add_train_to_station_list
      @route.stations[@current_station_position].to_accept_train(self)
    end

    # удаление поезда из списка поездов станции
    def remove_train_from_station_list
      @current_station.remove_train(self)
    end
end