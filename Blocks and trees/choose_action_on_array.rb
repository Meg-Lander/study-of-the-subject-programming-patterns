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
  array.all? { |num| num <= element } # Проверяем, что все элементы <= текущего
end

filename = "numbers.txt"
array, index = read_from_file(filename)

loop do
  puts "\nВыберите задачу:"
  puts "1. Проверка на глобальный максимум"
  puts "2. Выход"
  choice = gets.to_i

  case choice
  when 1
    begin
      if global_maximum?(array, index)
        puts "Элемент по индексу #{index} является глобальным максимумом."
      else
        puts "Элемент по индексу #{index} не является глобальным максимумом."
      end
    rescue ArgumentError => e
      puts "Ошибка: #{e.message}"
    end
  when 2
    puts "Выход из программы"
    break
  else
    puts "Некорректный выбор. Попробуйте снова"
  end
end
