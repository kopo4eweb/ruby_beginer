require_relative 'cargo_carriage'
require_relative 'passenger_carriage'

class CarriageInterface
  def self.menu(train)
    @@train = train

    loop do
      puts "Поезд: #{train.number}, вагонов: #{train.carriages.size}"
      puts 'Введите цифру - выберите действие:'
      puts '1 - Прицепить вагон к поезду'
  
      if train.carriages.size > 0
        puts '2 - Отцепить вагон от поезда'
        puts '3 - Заполнить вагон'
        puts '4 - Вывести все вагоны поезда'
      end
  
      puts '0 - Вернуться в меню поезда'
      print '>> '
  
      operation = gets.chomp
      operation = -1 if operation !~ /^\d*$/
  
      puts "\n"
  
      case operation.to_i
        when 0
          break
        when 1
          puts '--> Прицепить вагон к поезду'
          add()
        when 2
          puts '--> Отцепить вагон от поезда'
          remove()
        when 3
          puts '--> Заполнить вагон'
          add_unit()
        when 4
          puts '--> Вывести все вагоны поезда'
          Templates.show_carriage(@@train)
      else
        puts '! Неизвестная операция'
      end
  
      puts "\n"
    end
  end

  def self.add
    return puts '! Остановите сначала поезд' if @@train.speed > 0

    begin
      puts 'Введите название производителя:'
      print '>> '
      company = gets.chomp.strip
      raise ArgumentError, 'Название компании не может быть пустым' if company.empty?
      company.capitalize!          
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry
    end
  
    begin
      puts 'Выберите тип вагонов:'
      puts '1 - Грузовые'
      puts '2 - Пассажирские'
      print '>> '
      type = gets.chomp.to_i

      if !TYPE.to_a[type - 1].nil?
        raise TypeError, "К поезду типа '#{@@train.type}' можно прицеплять вагоны только того же типа" if TYPE.to_a[type - 1][0] != @@train.type
      end
    
      input_carriage_block = Proc.new do |mess, class_carriage|
        begin
          puts mess
          print '>> '
          unit = gets.chomp.to_i          

          carriage = class_carriage.new(unit)
          carriage.company = company
          @@train.add_carriage(carriage)
        rescue ArgumentError => e 
          puts "! Ошибка: #{e.message}"
          retry
        end
      end

      if type == 1
        input_carriage_block.call('Введите объем грузового вагона:', CargoCarriage)
      elsif type == 2
        input_carriage_block.call('Введите кол-во мест в вагоне:', PassengerCarriage)
      else
        raise TypeError, 'Нет такого типа вагонов'
      end
    rescue TypeError => e
      puts "! Ошибка: #{e.message}"
      retry
    end   
  end
  
  def self.select(&block)
    return puts '! Остановите сначала поезд' if @@train.speed > 0

    Templates.show_carriage(@@train)

    begin
      puts 'Введите порядковый номер вагона:'
      print '>> '
      index = gets.chomp.to_i
      raise ArgumentError, 'Вагона под таким номером не существует' if index <= 0 || index > @@train.carriages.length
      yield(index - 1)
    rescue ArgumentError => e
      puts "! Ошибка: #{e.message}"
      retry
    end
  end

  def self.remove
    select { |index| @@train.remove_carriage(index) }
  end

  def self.add_unit
    select { |index| @@train.carriages[index].add_unit }
  end
end