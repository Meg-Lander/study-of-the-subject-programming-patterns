require_relative 'tag'

class HTML_tree
  attr_accessor :root
  include Enumerable

  def initialize(file_path)
    html_content = File.read(file_path)
    @root = parse_html(html_content)
  end

  def parse_html(content)
    stack = []
    root_tag = nil

    content.scan(/<(?<tag>\/?[\w\d]+)(?<attrs>[^>]*)>|(?<text>[^<]+)/).each do |tag, attrs, text|
      if tag
        if tag.start_with?('/')
          stack.pop
        else
          attributes = parse_attributes(attrs)
          new_tag = Tag.new(tag, attributes)

          if stack.empty?
            root_tag = new_tag
          else
            stack.last.add_child(new_tag)
          end
          stack.push(new_tag)
        end
      elsif text
        stack.last.content += text.strip if stack.any?
      end
    end
    root_tag
  end

  def parse_attributes(attrs_string)
    attrs = {}
    attrs_string.scan(/(\w+)=['"]([^'"]+)['"]/).each do |key, value|
      attrs[key] = value
    end
    attrs
  end

  def each(&block)
    depth_first_traversal(@root, &block)
  end

  def depth_first_traversal(node, &block)
    return unless node
    yield node
    node.children.each { |child| depth_first_traversal(child, &block) }
  end

  def breadth_first_each(&block)
    queue = [@root]
    until queue.empty?
      node = queue.shift
      yield node
      queue.concat(node.children)
    end
  end

  def to_s
    result = ""
    each { |tag| result += "#{tag.short_info}\n" }
    result
  end
end
