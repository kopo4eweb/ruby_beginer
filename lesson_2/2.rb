=begin
Заполнить массив числами от 10 до 100 с шагом 5
=end

array = []

(10..100).step(5) { |i| array << i }

puts array.inspect