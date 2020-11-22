# frozen_string_literal: true

# custom accessors
module Accessors
  def self.extended(base)
    base.extend ClassMethods
  end

  # methods for class
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_name = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)

          history_values = instance_variable_get(history_name) || []
          history_values << value
          instance_variable_set(history_name, history_values)
        end

        define_method("#{name}_history".to_sym) { instance_variable_get(history_name) }
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        error_message = "Не соответствие типов, разрешен тип: #{type}. Было передано '#{value}':#{value.class}"
        raise TypeError, error_message unless value.instance_of?(type)

        instance_variable_set(var_name, value)
      end
    end
  end
end
