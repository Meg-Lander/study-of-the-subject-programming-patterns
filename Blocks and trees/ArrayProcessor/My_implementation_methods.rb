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

  def min(value = nil)
    if !(block_given?) and value.nil?
      min_elem = self.array[0]
      self.array[1..].each do |potential_min_elem|
        if potential_min_elem < min_elem
          min_elem = potential_min_elem
        end
      return min_elem

      end
    
    elsif !(block_given?) and !(value.nil?)
      return self.array.sort[0..value-1]

    elsif block_given? and value.nil?
      min_elem = self.array[0]
      self.array[1..].each do |potential_min_elem|
        if yield(potential_min_elem, min_elem) == -1  # elem < min_elem
          min_elem = potential_min_elem
        end
      end

      return min_elem

    elsif block_given? and !(value.nil?)
      sorted_array = self.array[0..].sort do |a, b|
       yield(a, b)
      end

      return sorted_array[0..value-1] 
    end
  end

  

end

