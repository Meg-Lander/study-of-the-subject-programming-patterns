def read_from_file(filename)
  raise 'Файл не найден' unless File.exist?(filename)

  data = File.read(filename).split("\n")
  array = data[0].split.map(&:to_i)
  index = data[1].to_i
  [array, index]
end

def global_maximum?(array, index)
  raise ArgumentError, "Индекс выходит за пределы массива" if index >= array.size
  element = array[index]
  array.all? { |num| num <= element }
end

def local_minimum?(array, index)
  raise ArgumentError, "Индекс выходит за пределы массива" if index < 0 || index > array.size
  if index == 0
    if array[index] < array[index + 1]
      return true
    end
    false
  elsif index == array.size - 1
    if array[index] < array[index - 2]
      return true
    end
    false
  else
  element = array[index]
  [array[index - 1], array[index + 1]].all? { |x| x > element }
  end
end

def max_in_range(array)
  range = array.select{ |i| i >= 3 && i < array.size - 3 }
  range.max
end





filename = "numbers.txt"
array, index = read_from_file(filename)

loop do
  puts "\nВыберите задачу:"
  puts "1. Проверка на глобальный максимум"
  puts "2. Проверка на локальный минимум"
  puts "3. Максимальный элемент в интервале"
  puts "4. Выход"
  choice = gets.to_i

  case choice
  when 1
    begin
      if global_maximum?(array, index)
        puts "Элемент по индексу #{index} является глобальным максимумом."
      else
        puts "Элемент по индексу #{index} не является глобальным максимумом."
      end
    end
  when 2
    begin
      if local_minimum?(array, index)
        puts "Элемент по индексу #{index} является локальным минимумом."
      else
        puts "Элемент по индексу #{index} не является локальным минимумом."
      end
    end
  when 3
    begin
      max_value = max_in_range(array)
      puts "Максимальный элемент в интервале #{max_value}."

    end
  
  when 4
    puts "Выход из программы. Мур-мур~"
    break
  else
    puts "Некорректный выбор. Попробуйте снова"
  end
end
