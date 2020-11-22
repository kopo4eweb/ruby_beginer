module Accessor
  def self.extended(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history_name = "@#{name}_history".to_sym
        
        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(var_name, value)

          # создать переменную-массив в которой хранить все значения текущей переменной
          history_values = instance_variable_get(history_name) || []
          history_values << value
          instance_variable_set(history_name, history_values)
        end
        
        define_method("#{name}_history".to_sym) { instance_variable_get(history_name) }
      end
    end

    def strong_attr_accessor(name, name_class)
      var_name = "@#{name}".to_sym # :@attr

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        error_message = "Не соответствие типов, разрешен тип: #{is_class}. Было передано '#{value}':#{value.class}"
        raise TypeError, error_message unless value.class == name_class
        instance_variable_set(var_name, value)
      end
    end
  end
end

class MyClass
  extend Accessor

  # 1
  # attr_accessor_with_history :name, :age, :city

  # 2
  # strong_attr_accessor(:name, String)
  # strong_attr_accessor(:age, Fixnum)
end

# 2
# test 'strong_attr_accessor'
# a = MyClass.new
# p a.name
# a.name = 'Art'
# p a.name
# a.age = 123
# a.name = 'Den'
# p a.name
# p a.age
# puts '-------------'

# 1
# test 'attr_accessor_with_history' and '<name_attr>_history'
# a = MyClass.new
# p a.name
# a.name = 'Art'
# p a.name
# a.name = 'Sem'
# a.name = 'Den'
# p a.name
# p a.name_history
# puts '-------------'
# p MyClass.methods
# puts '-------------'
# p a.methods
# puts '-------------'

# p a.age
# 1.upto(5) { |i| a.age = i*2 }
# p a.age
# p a.age_history
# p a.name_history
# puts '-------------'

# p a.city
# p a.city_history