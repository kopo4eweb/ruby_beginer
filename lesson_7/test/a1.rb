# input_carriage_block = Proc.new do |mess, class_carriage|
#   begin
#     puts mess
#     print '>> '
#     unit = gets.chomp.to_i          

#     carriage = class_carriage.new(unit)
#     carriage.company = company
#     @@train.add_carriage(carriage)
#   rescue ArgumentError => e 
#     puts "! Ошибка: #{e.message}"
#     retry
#   end
# end
# input_carriage_block.call('Введите объем грузового вагона:', CargoCarriage)

b1 = Proc.new do
  puts 'list carriage'
  # return 101
end
y = 10
l = proc { |i, y| y = i; puts "#{y} #{i}" }

b1.call()
l.call(22)

puts y