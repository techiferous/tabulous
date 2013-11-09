require_relative '../../../spec_helper'

describe "the tab DSL" do
  context "with all declarations" do
    before(:each) do
      @tab = Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
      class DummyViewContext
        def controller_path
          'cookies'
        end
        def action_name
          'eat'
        end
      end
      @view = DummyViewContext.new
    end

    it "should return a tab" do
      @tab.should be_a(Tabulous::Tab)
    end

    it "should use the values given" do
      @tab.text.should == 'text'
      @tab.link_path.should == 'path'
      @tab.http_verb.should == :post
      @tab.visible?.should be_true
      @tab.enabled?.should be_false
      @tab.active?(@view).should be_true
    end
  end

  it "should complain if 'text' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        link_path     'path'
        http_verb     :post
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
    }.to raise_error(Tabulous::MissingDeclarationError)
  end

  it "should complain if 'link_path' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        http_verb     :post
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
    }.to raise_error(Tabulous::MissingDeclarationError)
  end

  it "should not complain if 'http_verb' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
    }.to_not raise_error(Tabulous::MissingDeclarationError)
  end

  it "should complain if 'visible_when' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
    }.to raise_error(Tabulous::MissingDeclarationError)
  end

  it "should complain if 'enabled_when' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        visible_when  true
        active_when   { in_action('any').of_controller('cookies') }
      end
    }.to raise_error(Tabulous::MissingDeclarationError)
  end

  it "should complain if 'active_when' is missing" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        visible_when  true
        enabled_when  false
      end
    }.to raise_error(Tabulous::MissingDeclarationError)
  end

  it "should allow multiple actions to be set active" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        visible_when  true
        enabled_when  false
        active_when do
          in_action('foo').of_controller('cookies')
          in_action('bar').of_controller('cookies')
        end
      end
    }.to_not raise_error
  end

  it "should allow multiple actions to be set active using in_actions" do
    expect {
      Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :post
        visible_when  true
        enabled_when  false
        active_when   { in_actions('foo', 'bar').of_controller('cookies') }
      end
    }.to_not raise_error
  end

  context "with literal values" do
    before(:each) do
      @tab = Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        http_verb     :patch
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
    end

    it "should use the values given" do
      @tab.text.should == 'text'
      @tab.link_path.should == 'path'
      @tab.http_verb.should == :patch
      @tab.visible?.should be_true
      @tab.enabled?.should be_false
    end
  end

  context "with lazily evaluated values" do
    before(:each) do
      @tab = Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          { 'te' + 'xt' }
        link_path     { 'path' }
        http_verb     { :delete }
        visible_when  { 5 == 5 }
        enabled_when  { false }
        active_when   { in_action('any').of_controller('cookies') }
      end
    end

    it "should evaluate the values given" do
      @tab.text.should == 'text'
      @tab.link_path.should == 'path'
      @tab.http_verb.should == :delete
      @tab.visible?.should be_true
      @tab.enabled?.should be_false
    end
  end

  context "with no optional declarations" do
    before(:each) do
      @tab = Tabulous::Dsl::Tab.process('tab_name', nil) do
        text          'text'
        link_path     'path'
        visible_when  true
        enabled_when  false
        active_when   { in_action('any').of_controller('cookies') }
      end
      class DummyViewContext
        def controller_path
          'cookies'
        end
        def action_name
          'eat'
        end
      end
      @view = DummyViewContext.new
    end

    context "http_verb" do
      let(:http_verb) { @tab.http_verb }

      it "should default to :get" do
        http_verb.should == :get
      end
    end
  end
end
