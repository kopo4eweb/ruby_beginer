class Y
  define_method(:my_method) do
    puts 'Run my method'
  end
end

p Y

y = Y.new
y.my_method
