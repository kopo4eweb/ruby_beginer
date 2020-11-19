# frozen_string_literal: true

require_relative 'instance_counter'

# structure of route
class Station
  include InstanceCounter

  NAME_FORMAT = /^[а-яa-z0-9\-.\ ]{2,}$/i.freeze

  attr_reader :trains, :name

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

  def validate!
    error_message = 'Допустииый формат для имени станции: минимум 2 символа, ' \
    'буквы, цифры, знаки: минус, точка, пробел'
    raise ArgumentError, error_message unless @name =~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue StandardError
    false
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
