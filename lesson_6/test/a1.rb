# 1
# def raise_exception  
#   puts 'I am before the raise.'  
#   raise 'An error has occured'  
#   puts 'I am after the raise'  
# end  
# raise_exception

# 2
# def inverse(x)  
#   raise ArgumentError, 'Argument is not numeric' unless x.is_a? Numeric  
#   1.0 / x  
# end  
# puts inverse(2)  
# puts inverse('not a number')  

# 3
# def raise_and_rescue  
#   begin  
#     puts 'I am before the raise.'  
#     raise 'An error has occured.'  
#     puts 'I am after the raise.'  
#   rescue  
#     puts 'I am rescued.'  
#   end  
#   puts 'I am after the begin block.'  
# end  
# raise_and_rescue  

# 4
# begin  
#   raise 'A test exception.'  
# rescue StandardError => e  
#   puts e.message  
#   puts e.backtrace.inspect  
# end 

# 5
begin  
  File.open('a1.rb', 'r') do |f1|  
    while line = f1.gets  
      puts line  
    end  
  end  
  
  # Create a new file and write to it  
  File.open('test.rb', 'w') do |f2|  
    # use "" for two lines of text  
    f2.puts "Created by Satish\nThank God!"  
  end  
rescue StandardError => msg  
  # display the system generated error message  
  puts msg  
end  