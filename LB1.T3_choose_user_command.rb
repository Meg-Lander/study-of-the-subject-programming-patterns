puts "Hello, user write your name"
user = gets
puts "hello what your like leng #{user}"

#Нужно использовать chomp после gets, чтобы убрать лишний символ переноса строки
lang = gets.chomp

case lang
when "ruby"
  puts "О, #{user}, ты подлиза!"

when "python"
  puts "Хм, Python хорош, но скоро будет Ruby!"

when "c++"
  puts "C++ мощный, но Ruby тоже скоро понравится!"

when "java"
  puts "Java интересен, но Ruby завоюет твое сердце!"
  
 else
  puts "Хм, интересный выбор, но скоро будет Ruby!"
end

#============================================

puts "Введите команду на языке Ruby:"
rb_comd = gets.chomp 

begin
  result = eval(rb_comd)
  puts "Результат команды Ruby: #{result}"
end

puts "Введите команду для операционной системы:"
os_comd = gets.chomp

system(os_comd)
puts "Команда ОС выполнена успешно!"
