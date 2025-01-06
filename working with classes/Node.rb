require 'date'
require_relative 'binary_tree'

class Node
  include Comparable

  attr_accessor :student, :left, :right

  def initialize(student)
    @student = student
    @left = nil
    @right = nil
  end
end

