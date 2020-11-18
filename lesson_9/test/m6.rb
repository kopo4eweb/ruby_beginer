class C
  def m
    puts 'Hello'
  end

  def method_missing(name, *args)
    puts "Called method '#{name}' with arguments #{args}"
  end
end

c = C.new
# is created
c.m

# created dymamic
c.hula
c.tralala(1012, 3.1456, 'string', :sym)

class D
  def method_missing(name, *args)
    self.class.send(:define_method, name.to_sym, lambda { |*args| puts args.inspect })
  end
end

d = D.new
p d
p d.public_methods

p d.abc(1, 2, 3)
d.abc(5,6,7)
p d.public_methods
