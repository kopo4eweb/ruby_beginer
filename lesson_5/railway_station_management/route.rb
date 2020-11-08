require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations # выводить список всех станций по порядку

  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end

    @stations = [station_start, station_end]
    register_instance()
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