module X
end

class A
  @@v = 10

  include X
end

p A.class_eval('@@v')

A.class_eval do
  def m
    puts "I'm instance method"
  end
end

a = A.new
a.m

A.class_eval do
  def self.m
    puts "I'm class method"
  end
end

A.m
a.m

X.module_eval do
  def module_method
    puts "I'm methods created in module"
  end
end

a.module_method

class A
  def initialize
    @x = 'x variable'
  end

  class_eval do
    def another_method
      puts "I'm another methods"
      puts "gets instance varible #{@x}"
    end
  end
end

puts '-------------'

a.another_method
puts '-------------'

a2 = A.new
a2.another_method
puts '-------------'

p A.class_variables
p A.class_variable_get :@@v
A.class_variable_set :@@v, 554433
p A.class_variable_get :@@v
A.class_variable_set :@@r, 'Hello Kity'
p A.class_variables
puts '-------------'

p a.instance_variables
b = A.new
p b.instance_variables

puts '-------------'
p b.instance_variable_get :@x
b.instance_variable_set :@k, 1234567890
p b.instance_variables