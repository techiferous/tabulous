require_relative '../../spec_helper'

describe Tabulous::Tab do
  before(:each) do
    class DummyViewContext
      def some_text
        'some text'
      end
      def some_boolean
        true
      end
      def controller_path
        'cookies'
      end
      def action_name
        'eat'
      end
    end
    @view = DummyViewContext.new
  end

  it "should allow name to be set" do
    subject.name = 'name'
    subject.name.should == 'name'
  end

  it "should allow text to be set" do
    subject.text = 'foo'
    subject.text.should == 'foo'
  end

  it "should allow text to be set lazily" do
    subject.text = lambda { some_text }
    subject.text(@view).should == 'some text'
  end

  it "should allow link_path to be set" do
    subject.link_path = 'foo'
    subject.link_path.should == 'foo'
  end

  it "should allow link_path to be set lazily" do
    subject.link_path = lambda { some_text }
    subject.link_path(@view).should == 'some text'
  end

  it "should allow http_verb to be set" do
    subject.http_verb = :put
    subject.http_verb.should == :put
  end

  it "should allow http_verb to be set lazily" do
    subject.http_verb = lambda { :put }
    subject.http_verb(@view).should == :put
  end

  it "should allow visible_when to be set" do
    subject.visible_when = false
    subject.visible?.should be_false
  end

  it "should allow visible_when to be set lazily" do
    subject.visible_when = lambda { some_boolean }
    subject.visible?(@view).should be_true
  end

  it "should allow enabled_when to be set" do
    subject.enabled_when = false
    subject.enabled?.should be_false
  end

  it "should allow enabled_when to be set lazily" do
    subject.enabled_when = lambda { some_boolean }
    subject.enabled?(@view).should be_true
  end

  it "should be a tab by default" do
    subject.subtab?.should be_false
  end

  it "should be able to be a subtab" do
    subject.kind = :subtab
    subject.subtab?.should be_true
  end

  it "should allow parent tab to be set" do
    parent = Tabulous::Tab.new
    subtab = Tabulous::Tab.new
    subtab.kind = :subtab
    subtab.parent.should be_nil
    subtab.parent = parent
    subtab.parent.should == parent
  end

  it "should not allow parent tab to be set if not a subtab" do
    parent = Tabulous::Tab.new
    not_a_subtab = Tabulous::Tab.new
    expect { not_a_subtab.parent = parent }.to raise_error
  end

  it "should be in the parent's subtabs after setting parent" do
    parent = Tabulous::Tab.new
    subtab = Tabulous::Tab.new
    subtab.kind = :subtab
    parent.subtabs.should match_array([])
    subtab.parent = parent
    parent.subtabs.should match_array([subtab])
  end

  describe "#active?" do
    it "should be false by default" do
      subject.active?(@view).should be_false
    end

    it "should be true if the current action and current controller matches the active actions" do
      subject.add_active_actions('cookies', ['bake', 'eat'])
      subject.active?(@view).should be_true
    end

    it "should be false if the current action but not the current controller matches the active actions" do
      subject.add_active_actions('cakes', ['bake', 'eat'])
      subject.active?(@view).should be_false
    end

    it "should be false if the current controller but not the current action matches the active actions" do
      subject.add_active_actions('cookies', ['bake', 'buy'])
      subject.active?(@view).should be_false
    end

    it "should be true if the current controller matches and the active action is any" do
      subject.add_active_actions('cookies', 'any')
      subject.active?(@view).should be_true
    end

    it "should be false if the current controller does not match and the active action is any" do
      subject.add_active_actions('cakes', 'any')
      subject.active?(@view).should be_false
    end

    it "should be true if a subtab is active" do
      parent = Tabulous::Tab.new
      subtab = Tabulous::Tab.new
      subtab.kind = :subtab
      subtab.parent = parent
      subtab.add_active_actions('cookies', 'eat')
      parent.active?(@view).should be_true
    end

    it "should be true if a subtab is active" do
      parent = Tabulous::Tab.new
      subtab = Tabulous::Tab.new
      subtab.kind = :subtab
      subtab.parent = parent
      subtab.add_active_actions('cookies', 'eat')
      parent.active?(@view).should be_true
    end
  end

  describe "#clickable?" do
    it "should be true if enabled" do
      subject.enabled_when = true
      subject.clickable?(@view).should be_true
    end

    it "should be false if not enabled" do
      subject.enabled_when = false
      subject.clickable?(@view).should be_false
    end

    context "when active and enabled" do
      before(:each) do
        @tab = Tabulous::Tab.new
        @tab.enabled_when = true
        @tab.add_active_actions('cookies', 'eat')
      end

      it "should be false if active_tab_clickable is false" do
        Tabulous::Config.active_tab_clickable = false
        @tab.clickable?(@view).should be_false
      end

      it "should be true if active_tab_clickable is true" do
        Tabulous::Config.active_tab_clickable = true
        @tab.clickable?(@view).should be_true
      end
    end
  end

  describe "#active_actions_overlap?" do
    it "should return false if active actions do not overlap" do
      tab1 = Tabulous::Tab.new
      tab1.add_active_actions('cookies', 'eat')
      tab2 = Tabulous::Tab.new
      tab2.add_active_actions('cookies', 'chew')
      tab1.active_actions_overlap?(tab2).should be_false
    end

    it "should return false if active actions do not overlap" do
      tab1 = Tabulous::Tab.new
      tab1.add_active_actions('cookies', 'eat')
      tab2 = Tabulous::Tab.new
      tab2.add_active_actions('cakes', 'eat')
      tab1.active_actions_overlap?(tab2).should be_false
    end

    it "should return true if active actions do overlap" do
      tab1 = Tabulous::Tab.new
      tab1.add_active_actions('cookies', 'eat')
      tab2 = Tabulous::Tab.new
      tab2.add_active_actions('cookies', 'eat')
      tab1.active_actions_overlap?(tab2).should be_true
    end

    it "should return true if active actions do overlap" do
      tab1 = Tabulous::Tab.new
      tab1.add_active_actions('cookies', 'any')
      tab2 = Tabulous::Tab.new
      tab2.add_active_actions('cookies', 'eat')
      tab1.active_actions_overlap?(tab2).should be_true
    end
  end
end
