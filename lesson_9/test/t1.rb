class Array
  def foldl(method)
    inject {|result, i| result ? result.send(method, i) : i }
  end
end

puts [1000.0, 200.0, 50.0].foldl("/")
puts [1000.0, 200.0, 50.0].foldl("+")
puts [1000.0, 200.0, 50.0].foldl("-")
puts [1000.0, 200.0, 50.0].foldl("*")

puts '--------'

class SetInStone
  #empty class
end

class SetInStone
  def everything_changes
    return "Wait, what? You just added a method to me!"
  end
end

puts SetInStone.new.everything_changes

puts '--------'

class String
  def words
    self.split
  end
end

p 'I am a string'.words