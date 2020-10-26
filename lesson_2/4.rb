=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

array_vowels = ['а', 'и', 'о', 'у', 'ы', 'е', 'э', 'ю', 'я']
hash_vowels = {}

('а'..'я').each_with_index do |char, index| 
  array_vowels.each { |vowel| hash_vowels[char] = index + 1 if char == vowel }
end

puts hash_vowels.inspect