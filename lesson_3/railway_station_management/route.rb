=begin
Класс Route (Маршрут):
+ Имеет начальную и конечную станцию, а также список промежуточных станций. 
  Начальная и конечная станции указываютсся при создании маршрута, 
  а промежуточные могут добавляться между ними.
+ Может добавлять промежуточную станцию в список
+ Может удалять промежуточную станцию из списка
+ Может выводить список всех станций по-порядку от начальной до конечной
=end

class Route
  attr_reader :stations # выводить список всех станций по порядку

  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end

    @stations = []
    @stations << station_start
    @stations << station_end
  end

  # добавление промежуточных станций
  def add_station(station)
    @stations.insert(-2, station)
  end

  # удаление промежуточных станций
  def remove_station(station)
    @stations.delete(station) unless station == @station_start || station == @station_end
  end
end