=begin
Прямоугольный треугольник. 
Программа запрашивает у пользователя 3 стороны треугольника и определяет, 
является ли треугольник прямоугольным (используя теорему Пифагора www-formula.ru), 
равнобедренным (т.е. у него равны любые 2 стороны)  или равносторонним 
(все 3 стороны равны) и выводит результат на экран. 
Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти 
самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате с суммой 
квадратов двух остальных сторон. Если все 3 стороны равны, то треугольник 
равнобедренный и равносторонний, но не прямоугольный.
=end

puts '--=== Прямоугольный треугольник ===--'

puts 'Введите сторону: a'
a = gets.chomp.to_f.round(4)
a = (a**2).round(half: :even)

puts 'Введите сторону: b'
b = gets.chomp.to_f.round(4)
b = (b**2).round(half: :even)

puts 'Введите сторону: c'
c = gets.chomp.to_f.round(4)
c = (c**2).round(half: :even)

if a == b && a == c
  puts "треугольник равнобедренный и равносторонний: стороны a:#{a}, b:#{b}, c:#{c}"
elsif a == b || b == c || a == c
  print 'треугольник равнобедренный: '

  if a == b
    puts "стороны a:#{a} и b:#{b} равны"
  elsif b == c
    puts "стороны b:#{b} и c:#{c} равны"
  else
    puts "стороны a:#{a} и c:#{c} равны"
  end
elsif b + c == a
  puts "треугольник прямоугольный: гипотинуза a:#{a}, стороны b:#{b}, c:#{c}"
elsif a + c == b
  puts "треугольник прямоугольный: гипотинуза b:#{b}, стороны a:#{a}, c:#{c}"
elsif a + b == c
  puts "треугольник прямоугольный: гипотинуза c:#{c}, стороны a:#{a}, b:#{b}"
else
  puts "треугольник другой формы: стороны a:#{a}, b:#{b}, c:#{c}"
end