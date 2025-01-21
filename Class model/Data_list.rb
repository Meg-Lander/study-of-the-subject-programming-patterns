class Data_list
  attr_reader :elements
  private :elements

  def initialize(elements)
    self.elements = elements.freeze
  end

  def elements=(new_elements)
    @elements = new_elements
  end

  
end