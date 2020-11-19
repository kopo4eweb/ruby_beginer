class Glider
  def lift
    puts "Rising"
  end
  
  def bank
    puts "Turning"
  end
end

class Nomad
  def initialize(glider)
    @glider = glider
  end

  def do(action)
    if action == 'lift'
      @glider.lift
    elsif action == 'bank'
      @glider.bank
    else
      raise NoMethodError.new(action)
    end
  end
end

nomad = Nomad.new(Glider.new)
nomad.do("lift")
nomad.do("bank")
# nomad.do("up")

puts '--------'

class Nomad
  def do(action)
    @glider.send(action)
  end
end

nomad = Nomad.new(Glider.new)
nomad.do("lift")
nomad.do("bank")

puts '--------'

class Glider
  def lift(g = nil)
    puts "Rising#{g ? " #{g} deg" : ''}"
  end
  
  def bank(g = nil)
    puts "Turning#{g ? " #{g} deg" : ''}"
  end
end

class Nomad
  def do(action, argument = nil)
    if argument == nil
      @glider.send(action)
    else
      @glider.send(action, argument)
    end
  end
end

nomad = Nomad.new(Glider.new)
nomad.do("lift", 30)
nomad.do("bank")

puts '--------'

def relly(data, data_type)
  data.map { |item| item.send("to_#{data_type}") }
end

p relly([1, 2, 3, 4], 's')
p relly([1, 2, 3, 4], 'r')
p relly(%w(1 2 3 4 5), 'i')