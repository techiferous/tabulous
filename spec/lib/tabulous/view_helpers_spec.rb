require_relative '../../spec_helper'

describe Tabulous::ViewHelpers do
  before(:each) do
    class DummyClass
      include Tabulous::ViewHelpers
    end
  end

  it "should define tabs" do
    DummyClass.new.should respond_to(:tabs)
  end

  it "should define subtabs" do
    DummyClass.new.should respond_to(:subtabs)
  end
end
