class Array_processor

  def initialize(array)
    @array = array.freeze # Запрещаем изменение массива
  end

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

  def min
    min_element = nil
    each do |element|
      if min_element.nil? || (block_given? ? yield(element, min_element) < 0 : element <=> min_element < 0)
        min_element = element
      end
    end
    min_element
  end

  def partition
    truthy = []
    falsy = []
    @array.each do |element|
      if yield(element)
        truthy << element
      else
        falsy << element
      end
    end
    [truthy, falsy]
  end

  def take_while
    result = []
    @array.each do |element|
      break unless yield(element)

      result << element
    end
    result
  end

end

