=begin
Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя). 
Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным. 
(Запрещено использовать встроенные в ruby методы для этого вроде Date#yday или Date#leap?) 
Алгоритм опредления високосного года: www.adm.yar.ru
Год високосный, если он делится на четыре без остатка, но если он делится на 100 без остатка, 
это не високосный год. Однако, если он делится без остатка на 400, это високосный год. 
Таким образом, 2000 г. является особым високосным годом, который бывает лишь раз в 400 лет. 
=end

puts 'Введите день (число от 1 до 31):'
num_day = gets.chomp.to_i

return puts 'Ошибка - дня с таким номером не сужествует.' if num_day < 1 || num_day > 31

puts 'Введите месяц (число от 1 до 12):'
num_mounth = gets.chomp.to_i

return puts 'Ошибка - месяца с таким номером не существует.' if num_mounth < 1 || num_mounth > 12

array_mounths = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

puts 'Введите год (число, например 2020):'
num_year = gets.chomp.to_i

if (num_year % 4 == 0 && num_year % 100 != 0) || num_year % 400 == 0
  array_mounths[1] = 29
end

return puts 'Ошибка - в этом месяце меньшее кол-во дней' if num_day > array_mounths[num_mounth - 1] 

mounths_day = 0
index = num_mounth - 1

while index > 0 do
  index -= 1
  mounths_day += array_mounths[index]        
end

count_days = num_day + mounths_day
puts "Порядковый номер даты: #{count_days}"