# frozen_string_literal: true

require_relative 'instance_counter'

# structure of route
class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(station_start, station_end)
    @station_start = station_start
    @station_end = station_end

    @stations = [station_start, station_end]
    register_instance
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def remove_station(station)
    @stations.delete(station) unless station.equal?(@station_start) || station.equal?(@station_end)
  end
end
