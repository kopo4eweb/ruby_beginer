class Foo
  def initialize
    @val = "instance varible"
  end

  private

  def private_method
    puts 'This private method'
  end
end

foo = Foo.new

p foo.instance_eval('@val')
foo.instance_eval('private_method')

foo.instance_eval do
  def public_method(v)
    puts "#{@val}"
    private_method
    puts v
  end
end

foo.public_method('I am public method and more...')