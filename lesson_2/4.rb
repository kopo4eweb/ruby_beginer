=begin
Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
=end

array_vowels = ['а', 'и', 'о', 'у', 'ы', 'е', 'э', 'ю', 'я']
hash_vowels = {}
i = 1

('а'..'я').each do |char| 
  array_vowels.each { |vowel| hash_vowels[char] = i if char == vowel }
  i += 1
end

puts hash_vowels.inspect