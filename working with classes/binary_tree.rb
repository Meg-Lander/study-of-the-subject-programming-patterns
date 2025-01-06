require 'date'
require_relative 'student'
require_relative 'node'

class Binary_tree
  include Enumerable

  def initialize
    @root = nil
  end

  def add(student)
    @root = add_recursive(@root, student)
  end

  def each(&block)
    inorder_traversal(@root, &block)
  end

  private

  def add_recursive(node, student)
    return Node.new(student) if node.nil?

    if student.birth_date < node.student.birth_date
      node.left = add_recursive(node.left, student)
    else
      node.right = add_recursive(node.right, student)
    end

    node
  end

  def inorder_traversal(node, &block)
    return if node.nil?

    inorder_traversal(node.left, &block)
    yield node.student
    inorder_traversal(node.right, &block)
  end
end
