class MethodCall
  def initialize(sym, args)
    @sym = sym
    @args = args
  end
  
  def sym
    @sym
  end
  
  def args
    @args
  end
  
  def ==(other_call)
    @sym == other_call.sym && @args == other_call.args
  end
end

class Spy
  attr_reader :method_calls

  def initialize
    @method_calls = []
  end
  
  def method_missing(method, *args)
    @method_calls << MethodCall.new(method.to_sym, args.to_a)
  end

  def method_called?(sym, *args)
    m = MethodCall.new(sym.to_sym, args.to_a)

    @method_calls.each do |item|
      if item == m
        return true
      end
    end
    return false
  end
end

m = MethodCall.new('m', [1, 2, 3])
m2 = MethodCall.new('m', [1, 2, 3, 4])
p m

puts '----=-----'
p m == m2
puts '-----=----'

s = Spy.new()
s.hello
s.pay(44, 55, 66)

p s.instance_variable_get :@method_calls

puts '---1------'
p s.method_called?('hello')

puts '----2-----'
p s.method_called?('pay', 44, 55, 66)

puts '----2-1----'
p s.method_called?('pay', 44, 55, 66, 77)

puts '----3-----'
p s.method_calls