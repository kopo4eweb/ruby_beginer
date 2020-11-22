module Validation

  BASE_VALIDATION_NAME = '@validation'

  def self.extended(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  module ClassMethods
    def validate(name, *args)
      instance_variable_set(BASE_VALIDATION_NAME, {}) unless instance_variable_defined?(BASE_VALIDATION_NAME)
      instance_variable_get(BASE_VALIDATION_NAME)[name] = args
    end
  end

  # methods for instance
  module InstanceMethods
    def validate!
      validates = self.class.instance_variable_get(BASE_VALIDATION_NAME) || self.class.superclass.instance_variable_get(BASE_VALIDATION_NAME)
      validates.each { |name, args| send("validate_#{args[0]}", name, *args[1, args.size]) }
    end

    def valid?
      validate!
      true
    rescue
      false
    end

    protected

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      error_message = 'Поле не должно быть пустым'
      raise StandardError, error_message if value.nil? || value.empty?
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      error_message = "Не верный тип данных. Допустимый: #{type}, был передан: #{value.class}"
      raise StandardError, error_message unless value.class == type
    end

    def validate_format(name, regex_string, error_message)
      value = instance_variable_get("@#{name}")
      raise StandardError, error_message unless value =~ regex_string
    end
  end
end

class MyClass
  extend Validation

  validate :name, :presence
  validate :name, :type, String
  validate :name, :format, /^[а-яa-z0-9\-.\ ]{2,}$/i, 'Допустимое имя ....'
  
  def initialize(name)
    @name = name
    validate!
  end
end

class Child < MyClass
  validate :city, :presence
  validate :city, :type, String
  validate :city, :format, /^[а-яa-z0-9\-.\ ]{2,}$/i, 'Допустимое название города ....'

  def initialize(name, city)
    @city = city
    validate!
    super(name)
  end
end

m = MyClass.new('John')
p m.instance_variables

p m.valid?

c = Child.new('sdfg', 'NYS')
p c.instance_variables

p c.valid?