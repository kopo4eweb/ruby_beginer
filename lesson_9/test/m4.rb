module MyAttrAccessor
  # version 1
  def my_attr_accessor(name)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=".to_sym) { |v| instance_variable_set(var_name, v) }
  end

  # version 2
  def my_attr_accessor_new(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) { |v| instance_variable_set(var_name, v) }
    end
  end
end

class Test
  extend MyAttrAccessor

  my_attr_accessor :bird
  my_attr_accessor_new :cow, :pig, :horse
end

t = Test.new

t.bird = 'Chiken'
p t.bird

t.cow = 'Myyyy...'
t.pig = 'Hru-hru...'
t.horse = 'Igo-go-gooo...'

p t.instance_variables
p t