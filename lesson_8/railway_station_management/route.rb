require_relative 'instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end

    @stations = [station_start, station_end]
    register_instance
  end

  # добавление промежуточных станций
  def add_station(station)
    @stations.insert(-2, station)
  end

  # удаление промежуточных станций
  def remove_station(station)
    unless station.equal?(@station_start) || station.equal?(@station_end)
      @stations.delete(station)
    end
  end
end