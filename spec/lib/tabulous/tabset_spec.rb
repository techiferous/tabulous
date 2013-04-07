require_relative '../../spec_helper'

describe Tabulous::Tabset do
  before(:each) do
    class DummyViewContext
      def controller_path
        'cookies'
      end
      def action_name
        'eat'
      end
    end
    @view = DummyViewContext.new
    @tab1 = Tabulous::Tab.new
    @tab1.name = 'tab1'
    @tab1.add_active_actions('cakes', 'any')
    @subtab1 = Tabulous::Tab.new
    @subtab1.name = 'subtab1'
    @subtab1.kind = :subtab
    @subtab1.parent = @tab1
    @subtab1.add_active_actions('breads', 'any')
    @tab2 = Tabulous::Tab.new
    @tab2.name = 'tab2'
    @tab2.add_active_actions('cookies', 'any')
    subject.add_tab(@tab1)
    subject.add_tab(@subtab1)
    subject.add_tab(@tab2)
  end

  describe "#tabs" do
    it "should return in order all tabs" do
      subject.tabs.should == [@tab1, @subtab1, @tab2]
    end
  end

  describe "#primary_tabs" do
    it "should return in order all tabs that are not subtabs" do
      subject.primary_tabs.should == [@tab1, @tab2]
    end
  end

  describe "#active_primary_tab" do
    it "should return the tab that is active according to the current controller and action" do
      subject.active_primary_tab(@view).should == @tab2
    end
  end

  describe "#visible_subtabs" do
    it "should return an empty array if there are no visible subtabs" do
      subject.visible_subtabs(@view).should == []
    end
    it "should return an ordered array of visible subtabs if there are visible subtabs" do
      @subtab2 = Tabulous::Tab.new
      @subtab2.name = 'subtab2'
      @subtab2.kind = :subtab
      @subtab2.parent = @tab2
      @subtab2.visible_when = true
      @subtab3 = Tabulous::Tab.new
      @subtab3.name = 'subtab3'
      @subtab3.kind = :subtab
      @subtab3.parent = @tab2
      @subtab3.visible_when = false
      @subtab4 = Tabulous::Tab.new
      @subtab4.name = 'subtab4'
      @subtab4.kind = :subtab
      @subtab4.visible_when = true
      @subtab4.parent = @tab2
      subject.add_tab(@subtab2)
      subject.add_tab(@subtab3)
      subject.add_tab(@subtab4)
      subject.visible_subtabs(@view).should == [@subtab2, @subtab4]
    end
  end
end
