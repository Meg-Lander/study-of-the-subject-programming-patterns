# Метод для проверки, является ли число простым
def is_prime(num)
  return false if num <= 1
  (2..Math.sqrt(num)).each do |i|
    return false if num % i == 0
  end
  true
end

# Метод для нахождения максимального простого делителя
def max_prime_divisor(n)
  max_pr = -1
  (2..(n)).each do |i|
    if n % i == 0 && is_prime(i)
      max_pr = i
    end
  end
  max_pr
end

# Метод для выполнения операции в зависимости от первого аргумента
def process_numbers(method_name, numbers)
  numbers.each do |num|
    case method_name
    when "is_prime"
      puts "Число #{num} простое? #{is_prime(num)}"
    when "max_prime_divisor"
      result = max_prime_divisor(num)
      if result != -1
        puts "Максимальный простой делитель числа #{num}: #{result}"
      else
        puts "У числа #{num} нет простых делителей"
      end
    else
      puts "Неизвестный метод: #{method_name}"
    end
  end
end

# Основная программа
if ARGV.length != 2
  puts "Использование: ruby программа.rb <метод> <путь_к_файлу>"
  exit
end

method_name = ARGV[0]  # Первый аргумент — это имя метода (is_prime или max_prime_divisor)
file_path = ARGV[1]    # Второй аргумент — путь к файлу с числами

# Чтение чисел из файла
begin
  numbers = File.read(file_path).split.map(&:to_i)
rescue Errno::ENOENT
  puts "Файл не найден: #{file_path}"
  exit
end

# Выполнение метода
process_numbers(method_name, numbers)
