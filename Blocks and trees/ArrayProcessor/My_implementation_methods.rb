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

  def filter_map
    result = []
    @array.each do |element|
      value = yield(element)
      result << value if value
    end
    result
  end

  def group_by
    groups = {}
    @array.each do |element|
      key = yield(element)
      groups[key] ||= []
      groups[key] << element
    end
    groups
  end
  
end

