require File.expand_path('../unit_test_helper', File.dirname(__FILE__))
require 'tabulous/tabulous_formatter'

class TabulousFormatterTest < Test::Unit::TestCase

  # expected and actual are arrays of strings; they represent the
  # before and after contents of a text file that has been run
  # through TabulousFormatter
  def assert_same_text(expected, actual)
    # remove trailing whitespace as it doesn't matter for the purposes of diffing
    expected = expected.map(&:rstrip)
    actual = actual.map(&:rstrip)
    # now make one big string out of the array of strings
    expected = expected.join("\n")
    actual = actual.join("\n")
    message = Diffy::Diff.new(expected, actual).to_s(:color)
    assert_block(message) { expected == actual }
  end

  def test_returns_array_of_strings
    result = TabulousFormatter.format(['foo', 'bar'])
    assert_kind_of Array, result
    for element in result
      assert_kind_of String, element
    end
  end

  def test_empty_in_empty_out
    input = IO.readlines('test/test_initializers/empty')
    result = TabulousFormatter.format(input)
    assert_equal [], result
  end

  def test_text_in_text_out
    input = IO.readlines('test/test_initializers/text')
    expected = input
    actual = TabulousFormatter.format(input)
    assert_same_text expected, actual
  end

  def test_well_formatted_in_well_formatted_out
    input = IO.readlines('test/test_initializers/expected')
    expected = input
    actual = TabulousFormatter.format(input)
    assert_same_text expected, actual
  end

  def test_random_horizontal_whitespace
    input = IO.readlines('test/test_initializers/random_horizontal_whitespace')
    expected = IO.readlines('test/test_initializers/expected')
    actual = TabulousFormatter.format(input)
    assert_same_text expected, actual
  end

  def test_random_vertical_whitespace
    input = IO.readlines('test/test_initializers/random_vertical_whitespace')
    expected = IO.readlines('test/test_initializers/expected')
    actual = TabulousFormatter.format(input)
    assert_same_text expected, actual
  end

  def test_trailing_comments
    input = IO.readlines('test/test_initializers/trailing_comments')
    expected = input
    actual = TabulousFormatter.format(input)
    assert_same_text expected, actual
  end

end
