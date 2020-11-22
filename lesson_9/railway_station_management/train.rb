# frozen_string_literal: true

require_relative 'types'
require_relative 'company'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acсessors'

# base class
class Train
  include Company
  include InstanceCounter
  extend Validation
  extend Accessors

  NUMBER_FORMAT = /^[а-яa-z0-9]{3}-?[а-яa-z0-9]{2}$/i.freeze

  attr_reader :number, :carriages, :type
  attr_accessor :current_station

  attr_accessor_with_history :speed

  validate :number, :presence
  validate :number, :type, String
  error_message = 'Допустимый формат: три буквы или цифры в любом порядке, ' \
    'необязательный дефис (может быть, а может нет) и еще 2 ' \
    'буквы или цифры после дефиса.'
  validate :number, :format, NUMBER_FORMAT, error_message

  # rubocop:disable Style/ClassVars
  @@trains = []
  # rubocop:enable Style/ClassVars

  def self.find(number)
    @@trains.each { |train| return train if number == train.number }
    nil
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

  def carriages_list
    @carriages.each_with_index { |carriage, index| yield(carriage, index + 1) } if block_given?
  end

  def stop
    self.speed = 0
  end

  def add_carriage(carriade)
    @carriages << carriade
  end

  def remove_carriage(index)
    @carriages.delete_at(index)
  end

  def route(route)
    @route = route

    @current_station_position = 0

    add_train_to_station_list
  end

  def go_ahead
    @current_station_position += 1

    remove_train_from_station_list
    add_train_to_station_list
  end

  def go_back
    @current_station_position -= 1

    remove_train_from_station_list
    add_train_to_station_list
  end

  def prev_station
    @route.stations[@current_station_position - 1] if @current_station_position.positive?
  end

  def next_station
    @route.stations[@current_station_position + 1] if @current_station_position < @route.stations.length
  end

  private

  def add_train_to_station_list
    @route.stations[@current_station_position].accept_train(self)
  end

  def remove_train_from_station_list
    @current_station.send_train(self)
  end
end
