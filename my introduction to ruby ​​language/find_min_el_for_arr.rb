def find_min(arr)
  min_element = arr[0]
  i = 1
  while i < arr.length
    if arr[i] < min_element
      min_element = arr[i]
    end
    i += 1
  end
  min_element
end

def find_first_positive_index(arr)
  for i in 0...arr.length
    if arr[i] > 0
      return i
    end
  end
  nil
end


arr = [-3, -1, 0, -5, 2, 4, 6]


min_element = find_min(arr)
puts "Минимальный элемент: #{min_element}"

first_positive_index = find_first_positive_index(arr)
if first_positive_index
  puts "Индекс первого положительного элемента: #{first_positive_index}"
else
  puts "Положительных элементов нет"
end
