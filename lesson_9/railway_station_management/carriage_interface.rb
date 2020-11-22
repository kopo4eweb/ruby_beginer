# frozen_string_literal: true

require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

# interface for control carriages
class CarriageInterface
  class << self
    def selectable_operations
      puts "Поезд: #{@train.number}, вагонов: #{@train.carriages.size}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Прицепить вагон к поезду'

      if @train.carriages.size.positive?
        puts '2 - Отцепить вагон от поезда'
        puts '3 - Заполнить вагон'
        puts '4 - Вывести все вагоны поезда'
      end

      puts '0 - Вернуться в меню поезда'
      print '>> '

      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
      operation.to_i
    end

    def menu(train)
      @train = train

      loop do
        operation = selectable_operations

        puts "\n"

        case operation
        when 0
          break
        when 1
          puts '--> Прицепить вагон к поезду'
          add
        when 2
          puts '--> Отцепить вагон от поезда'
          remove
        when 3
          puts '--> Заполнить вагон'
          add_unit
        when 4
          puts '--> Вывести все вагоны поезда'
          Templates.show_carriage(@train)
        else
          puts '! Неизвестная операция'
        end

        puts "\n"
      end
    end

    def input_company
      begin
        puts 'Введите название производителя:'
        print '>> '
        company = gets.chomp.strip

        error_message = 'Название компании не может быть пустым'
        raise ArgumentError, error_message if company.empty?

        company.capitalize!
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end

      company
    end

    def input_carriage
      puts 'Выберите тип вагонов:'

      Type.classes.each_with_index do |type, index|
        puts "#{index + 1} - #{type}"
      end

      print '>> '
      type = gets.chomp.to_i

      error_message1 = 'Нет такого типа вагонов'
      raise ArgumentError, error_message1 if type <= 0 || type > Type.classes.size

      error_message2 = "К поезду типа '#{@train.type}' можно прицеплять вагоны только того же типа"
      raise ArgumentError, error_message2 unless Type.classes[type - 1] == @train.type

      type
    end

    def add_carriage(options)
      puts options[:mess]
      print '>> '
      unit = gets.chomp.to_i

      carriage = options[:class_carriage].new(unit)
      carriage.company = options[:company]
      @train.add_carriage(carriage)
    rescue ArgumentError => e
      Error.show_message(e.message)
      retry
    end

    def add
      return puts '! Остановите сначала поезд' if @train.speed.positive?

      company = input_company

      begin
        type = input_carriage

        case type
        when 1
          add_carriage(
            mess: 'Введите объем грузового вагона:',
            company: company,
            class_carriage: CargoCarriage
          )
        when 2
          add_carriage(
            mess: 'Введите кол-во мест в вагоне:',
            company: company,
            class_carriage: PassengerCarriage
          )
        end
      rescue ArgumentError => e
        Error.show_message(e.message)
        retry
      end
    end

    def select
      puts 'Введите порядковый номер вагона:'
      print '>> '
      index = gets.chomp.to_i

      error_message = 'Вагона под таким номером не существует'
      raise ArgumentError, error_message if index <= 0 || index > @train.carriages.length

      yield(index - 1)
    rescue ArgumentError => e
      Error.show_message(e.message)
      retry
    end

    def remove
      return puts '! Остановите сначала поезд' if @train.speed.positive?

      Templates.show_carriage(@train)

      select { |index| @train.remove_carriage(index) }
    end

    def add_unit
      return puts '! Остановите сначала поезд' if @train.speed.positive?

      Templates.show_carriage(@train)

      select { |index| @train.carriages[index].add_unit }
    end
  end
end
