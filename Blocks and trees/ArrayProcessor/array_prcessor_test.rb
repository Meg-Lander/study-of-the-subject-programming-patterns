require 'minitest/autorun'
require_relative 'My_implementation_methods'

class ArrayProcessorTest < Minitest::Test
  def setup
    @array = [1, 2, 3, 4, 5]
    @processor = Array_processor.new(@array)
  end

  def test_array
    assert_equal [1, 2, 3, 4, 5], @processor.array
  end

  def test_count
    assert_equal 2, @processor.count { |x| x.even? }
    assert_equal 3, @processor.count { |x| x > 2 }
  end

  def test_filter_map
    result = @processor.filter_map { |x| x * 2 if x.even? }
    assert_equal [4, 8], result
  end

  def test_group_by
    result = @processor.group_by { |x| x.even? }
    assert_equal({ true => [2, 4], false => [1, 3, 5] }, result)
  end

  def test_min_without_block
    assert_equal 1, @processor.min
  end

  def test_min_with_limit
    assert_equal [1, 2], @processor.min(2)
  end

  def test_min_with_block
    result = @processor.min { |a, b| b <=> a }
    assert_equal 5, result
  end

  def test_min_with_limit_and_block
    result = @processor.min(2) { |a, b| b <=> a }
    assert_equal [5, 4], result
  end

  def test_partition
    result = @processor.partition { |x| x.even? }
    assert_equal [[2, 4], [1, 3, 5]], result
  end

  def test_take_while
    result = @processor.take_while { |x| x < 4 }
    assert_equal [1, 2, 3], result
  end
end
