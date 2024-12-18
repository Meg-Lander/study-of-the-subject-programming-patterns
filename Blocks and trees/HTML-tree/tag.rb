class Tag
  attr_accessor :name, :attributes, :children, :content

  include Comparable

  def initialize(name, attributes = {}, content = '')
    @name = name
    @attributes = attributes
    @content = content.strip
    @children = []
  end

  def add_child(child)
    @children << child
  end

  def short_info
    children_names = @children.map(&:name).join(', ')
    "Тег: #{@name}, дети: #{children_names.empty? ? 'None' : children_names}, атрибуты: #{has_attributes?}, кол-во детей: #{children.size}"
  end

  def has_attributes?
    !@attributes.empty?
  end

  def tag_name
    @name
  end

  def to_s
    "<#{@name} #{attributes_string}>#{@content}</#{@name}>"
  end

  def attributes_string
    @attributes.map { |k, v| "#{k}='#{v}'" }.join(' ')
  end

  def <=>(other)
    children.size <=> other.children.size
  end
end
