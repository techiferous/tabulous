require_relative '../../spec_helper'

describe Tabulous::Config do

  it "should have all the options with the correct defaults" do
    Tabulous::Config.renderer.should == :default
    Tabulous::Config.active_tab_clickable.should == true
    Tabulous::Config.when_action_has_no_tab.should == :do_not_render
    Tabulous::Config.render_subtabs_when_empty.should == false
    Tabulous::Config.use_css_scaffolding.should == false
    Tabulous::Config.background_color.should == '#ccc'
    Tabulous::Config.text_color.should == '#444'
    Tabulous::Config.active_tab_color.should == '#fff'
    Tabulous::Config.hover_tab_color.should == '#ddd'
    Tabulous::Config.inactive_tab_color.should == '#aaa'
    Tabulous::Config.inactive_text_color.should == '#888'
  end

  it "should raise an error if renderer is set to a non-string or non-symbol value" do
    expect { Tabulous::Config.renderer = Fixnum }.to raise_error(Tabulous::ImproperValueError)
  end

  it "should raise an error if when_action_has_no_tab is set to a wrong value" do
    expect { Tabulous::Config.when_action_has_no_tab = :do_the_harlem_shake }.to raise_error(Tabulous::ImproperValueError)
  end

end
