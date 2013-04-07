require_relative '../../../spec_helper'

describe "the Tabulous.setup DSL" do

  it "should process 'customize' by passing it onto the Dsl::Config" do
    Tabulous::Dsl::Config.should_receive(:process)
    Tabulous::Dsl::Setup.process { customize }
  end

  it "should process 'use_css_scaffolding' by setting use_css_scaffolding to true" do
    ::Tabulous::Config.use_css_scaffolding = false
    Tabulous::Dsl::Setup.process { use_css_scaffolding }
    ::Tabulous::Config.use_css_scaffolding.should be_true
  end

  it "should process 'use_css_scaffolding' by passing it onto the Dsl::Config if a block is present" do
    Tabulous::Dsl::Config.should_receive(:process)
    Tabulous::Dsl::Setup.process do
      use_css_scaffolding do
      end
    end
  end

  it "should process 'tabs' by passing it onto the Dsl::Tabs" do
    Tabulous::Dsl::Tabs.should_receive(:process)
    Tabulous::Dsl::Setup.process { tabs }
  end

  it "should process 'tabs' by adding a new tabset" do
    tabset = Tabulous::Tabset.new
    Tabulous::Dsl::Tabs.should_receive(:process).and_return(tabset)
    Tabulous::Dsl::Setup.process { tabs(:name) }
    Tabulous::Tabsets.get(:name).should == tabset
  end

end
