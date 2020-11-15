require_relative 'instance_counter'

class Station
  include InstanceCounter

  NAME_FORMAT = /^[а-яa-z0-9\-\.\ ]{2,}$/i

  attr_reader :trains
  attr_reader :name

  @@stations = []

  def self.all
    @@stations
  end

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def validate!
    raise(
      RegexpError,
      'Допустииый формат для имени станции: минимум 2 символа, ' \
      'буквы, цифры, знаки: минус, точка, пробел'
      ) if @name !~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  # написать метод, который принимает блок и проходит по всем 
  # поездам на станции, передавая каждый поезд в блок.
  def get_trains(&block)
    if block_given?
      @trains.each { |train| yield(train) }
    end
  end

  # принятие поезда, добавляем поезд в список поездов,
  # метод вызывается поездом
  def accept_train(train)
    @trains << train

    # передаем текущую станцию в поезд для запоминания
    train.current_station = self
  end

  # отправляем поезд - удаляя поезд из списка станции
  # метод вызывается поездом
  def send_train(train)  
    @trains.delete(train)
  end
end