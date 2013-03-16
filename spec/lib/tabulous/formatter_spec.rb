require File.expand_path('../../spec_helper', File.dirname(__FILE__))
require 'tabulous/formatter'

describe Tabulous::Formatter do

  it "should return array of strings" do
    result = Tabulous::Formatter.format(['foo', 'bar'])
    result.should be_an(Array)
    for element in result
      element.should be_a(String)
    end
  end

  it "should return empty array if input is empty" do
    input = IO.readlines('spec/fixtures/empty')
    result = Tabulous::Formatter.format(input)
    result.should == []
  end

  it "should return generic text input unchanged" do
    input = IO.readlines('spec/fixtures/text')
    Tabulous::Formatter.format(input).should be_same_text_as(input)
  end

  it "should leave a well-formatted tabulous file well-formatted" do
    input = IO.readlines('spec/fixtures/expected')
    Tabulous::Formatter.format(input).should be_same_text_as(input)
  end

  it "should format random horizontal whitespace" do
    input = IO.readlines('spec/fixtures/random_horizontal_whitespace')
    expected = IO.readlines('spec/fixtures/expected')
    actual = Tabulous::Formatter.format(input)
    actual.should be_same_text_as(expected)
  end

  it "should format random vertical whitespace" do
    input = IO.readlines('spec/fixtures/random_vertical_whitespace')
    expected = IO.readlines('spec/fixtures/expected')
    actual = Tabulous::Formatter.format(input)
    actual.should be_same_text_as(expected)
  end

  it "should leave alone trailing comments" do
    input = IO.readlines('spec/fixtures/trailing_comments')
    Tabulous::Formatter.format(input).should be_same_text_as(input)
  end

end
