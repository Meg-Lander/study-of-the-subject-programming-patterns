require_relative 'My_implementation_methods'

array_processor = Array_processor.new([1, 2, 3, 4, 5, 6])

puts "Элементы массива: #{array_processor.array.inspect}"


puts "Количество чётных чисел: #{array_processor.count { |x| x.even? }}"


puts "Квадраты чётных чисел: #{array_processor.filter_map { |x| x * x if x.even? }.inspect}"


puts "Группировка по чётности: #{array_processor.group_by { |x| x.even? }}"

puts "Минимальный элемент: #{array_processor.min { |a, b| a < b }}"

truthy, falsy = array_processor.partition { |x| x > 3 }
puts "Элементы > 3: #{truthy.inspect}, Остальные: #{falsy.inspect}"

puts "Элементы, пока они < 4: #{array_processor.take_while { |x| x < 4 }.inspect}"