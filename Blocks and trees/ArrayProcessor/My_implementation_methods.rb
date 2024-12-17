class Array_processor

  def initialize(array)
    @array = array.freeze # Запрещаем изменение массива
  end

  # Метод для получения элементов массива
  def array
    @array
  end

  # Реализация метода count
  def count
    count = 0
    @array.each { |element| count += 1 if yield(element) }
    count
  end

  
end

