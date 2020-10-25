=begin
Заполнить массив числами фибоначчи до 100
=end

array = []

(0..100).each do |i|
  if i == 0
    array << 0
  elsif i == 1
    array << 1
  elsif i == 2
    array << 2
  else
    array << array[i - 2].to_i + array[i - 1].to_i
  end
end

puts array.inspect