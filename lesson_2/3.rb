=begin
Заполнить массив числами фибоначчи до 100
=end

array = [1, 1]
i = 1

loop do
  fibonachi_num =  array[i - 1] + array[i]

  break if fibonachi_num > 100

  array << fibonachi_num
  i += 1
end

puts array.inspect