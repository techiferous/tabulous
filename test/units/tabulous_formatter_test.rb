require File.expand_path('../unit_test_helper', File.dirname(__FILE__))
require 'tabulous/tabulous_formatter'

class TabulousFormatterTest < Test::Unit::TestCase

  def test_returns_array_of_strings
    result = TabulousFormatter.format(['foo', 'bar'])
    assert_kind_of Array, result
    for element in result
      assert_kind_of String, element
    end
  end

end
