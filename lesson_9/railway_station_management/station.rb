# frozen_string_literal: true

require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acсessors'

# structure of route
class Station
  include InstanceCounter
  extend Validation
  extend Accessors

  NAME_FORMAT = /^[а-яa-z0-9\-.\ ]{2,}$/i.freeze

  # attr_reader :trains, :name
  attr_reader :trains

  strong_attr_accessor :name, String

  validate :name, :presence
  validate :name, :type, String
  error_message = 'Допустииый формат для имени станции: минимум 2 символа, ' \
    'буквы, цифры, знаки: минус, точка, пробел'
  validate :name, :format, NAME_FORMAT, error_message

  class << self
    def add_station(station)
      @stations ||= []
      @stations << station
    end

    def all
      @stations
    end
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    self.class.add_station(self)
    register_instance
  end

  def get_trains(&block)
    @trains.each(&block) if block_given?
  end

  def accept_train(train)
    @trains << train
    train.current_station = self
  end

  def send_train(train)
    @trains.delete(train)
  end
end
