require 'date'
require_relative 'student'

class Binary_tree
  include Enumerable

  def initialize
    @root = nil
  end

  def add(student)
    @root = add_node(@root, student)
  end

  def add_node(node, student)
    return { data: student, left: nil, right: nil } if node.nil?

    if student.birth_date < node[:data].birth_date
      node[:left] = add_node(node[:left], student)
    else
      node[:right] = add_node(node[:right], student)
    end

    node
  end

  def each(&block)
    in_order_traversal(@root, &block)
  end

  private

  def in_order_traversal(node, &block)
    return if node.nil?

    in_order_traversal(node[:left], &block)
    yield node[:data]
    in_order_traversal(node[:right], &block)
  end
end
