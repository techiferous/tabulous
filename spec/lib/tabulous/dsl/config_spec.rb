require_relative '../../../spec_helper'

describe "the DSL for setting configuration values" do

  it "should process any call by setting the value directly on Tabulous::Config" do
    Tabulous::Config.text_color = 'blue'
    Tabulous::Config.active_tab_clickable = false
    Tabulous::Dsl::Config.process do
      text_color 'red'
      active_tab_clickable true
    end
    Tabulous::Config.text_color.should == 'red'
    Tabulous::Config.active_tab_clickable.should == true
  end

end
