require_relative 'instance_counter'

class Station
  include InstanceCounter

  attr_reader :trains # для возврата списка поездов на этой станции
  attr_reader :name

  NAME_FORMAT = /^[а-яa-z0-9\-\.\ ]{2,}$/i

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
    raise RegexpError, "Допустииый формат для имени станции: минимум 2 символа, буквы, цифры, знаки: минус, точка, пробел" if @name !~ NAME_FORMAT
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  # написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.
  def get_trains(&block)
    if block_given?
      @trains.each { |train| yield(train) }
    end
  end

  # принятие поезда, добавляем поезд в список поездовб,
  # метод вызывается поездом
  def accept_train(train)
    @trains << train

    # передаем текущую станцию в поезд для запоминания
    train.current_station = self
  end

  # возврящает хеш поездов на странции с кол-м поездов каждого типа
  # ! нигде не используется, раньше использовался в подсчете типов поездов в интерфейсе, заменен новым функционалом 
  # ! пока оставлю, в будущем возможно будет использован
  # def trains_list_type
  #   trains_type_count = Hash.new(0)

  #   @trains.each do |train|
  #     trains_type_count[train.type] += 1
  #   end

  #   return trains_type_count
  # end

  # отправляем поезд - удаляя поезд из списка станции
  # метод вызывается поездом
  def send_train(train)  
    @trains.delete(train)
  end
end