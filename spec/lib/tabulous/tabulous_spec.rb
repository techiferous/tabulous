require_relative '../../spec_helper'

describe Tabulous do
  it "should have a setup method" do
    Tabulous.should respond_to(:setup)
  end
end
