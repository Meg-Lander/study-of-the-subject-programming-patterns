class Data_list
  attr_accessor :elements

  def initialize(elements)
    self.elements = elements
  end

  def elements=(new_elements)
    @elements = new_elements.freeze
  end

  def select(number)
    self.elements[number]
  end

  def get_selected(ids)
    selected_elements = []

    ids.each do |id|
      if id >= 0 && id < self.elements.size
        selected_elements << self.elements[id]
      end
    end

    selected_elements.join(", ")
  end

  def get_names
    ["№"] + attribute_names
  end

  def get_data
    data = elements.map.with_index do |element, index|
      [index + 1] + extract_attributes(element)
    end
    Data_table.new(data)
  end

  def to_s
    elements.join(", ")
  end

  private

  def attribute_names
    raise NotImplementedError, "Метод 'attribute_names' должен быть переопределён в наследнике"
  end

  def extract_attributes(element)
    raise NotImplementedError, "Метод 'extract_attributes' должен быть переопределён в наследнике"
  end
end