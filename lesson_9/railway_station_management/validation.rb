# frozen_string_literal: true

# custom validation
module Validation
  NAME = '@validation'

  def self.extended(base)
    base.extend ClassMethods
    base.include InstanceMethods
  end

  # methods for class
  module ClassMethods
    def validate(name, *args)
      instance_variable_set(NAME, {}) unless instance_variable_defined?(NAME)
      instance_variable_get(NAME)[name] = args
    end
  end

  # methods for instance
  module InstanceMethods
    def validate!
      validates = self.class.instance_variable_get(NAME) || self.class.superclass.instance_variable_get(NAME)
      validates.each { |name, args| send("validate_#{args[0]}", name, *args[1, args.size]) }
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    protected

    def validate_presence(name)
      value = instance_variable_get("@#{name}")
      error_message = 'Поле не должно быть пустым'
      raise ArgumentError, error_message if value.nil? || value.empty?
    end

    def validate_type(name, type)
      value = instance_variable_get("@#{name}")
      error_message = "Не верный тип данных. Допустимый: #{type}, был передан: #{value.class}"
      raise ArgumentError, error_message unless value.instance_of?(type)
    end

    def validate_format(name, regex_string, error_message)
      value = instance_variable_get("@#{name}")
      raise ArgumentError, error_message unless value =~ regex_string
    end

    def validate_positive(name, error_message)
      value = instance_variable_get("@#{name}")
      raise ArgumentError, error_message if value <= 0
    end
  end
end
