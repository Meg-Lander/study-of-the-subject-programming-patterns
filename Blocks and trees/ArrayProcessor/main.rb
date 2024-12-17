require_relative 'My_implementation_methods'

array_processor = Array_processor.new([1, 2, 3, 4, 5, 6])

puts "Элементы массива: #{array_processor.elements.inspect}"


puts "Количество чётных чисел: #{array_processor.count { |x| x.even? }}"


puts "Квадраты чётных чисел: #{array_processor.filter_map { |x| x * x if x.even? }.inspect}"

