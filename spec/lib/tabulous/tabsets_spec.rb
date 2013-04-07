require_relative '../../spec_helper'

describe "Tabulous::Tabsets" do
  it "should allow you to add and retrieve tabsets by key" do
    dummy = Object.new
    Tabulous::Tabsets.add('dummy', dummy)
    Tabulous::Tabsets.get('dummy').should == dummy
  end

  it "should treat symbol keys and string keys the same" do
    dummy = Object.new
    dummy2 = Object.new
    Tabulous::Tabsets.add('dummy', dummy)
    Tabulous::Tabsets.add(:dummy2, dummy2)
    Tabulous::Tabsets.get('dummy').should == dummy
    Tabulous::Tabsets.get(:dummy).should == dummy
    Tabulous::Tabsets.get('dummy2').should == dummy2
    Tabulous::Tabsets.get(:dummy2).should == dummy2
  end
end
