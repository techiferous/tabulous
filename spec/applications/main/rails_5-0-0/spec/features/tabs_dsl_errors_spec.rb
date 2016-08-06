require 'spec_helper'

describe 'tabs DSL' do
  include TabHelpers

  context 'starting with a subtab' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_subtab do
              text          { 'tab name' }
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::SubtabOutOfOrderError)
    end
  end

  context 'improperly named tab' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home do
              text          { 'tab name' }
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it 'should raise an error' do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::TabNameError)
    end
  end

  context 'tabs with the same name' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          { 'tab name' }
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
            other_tab do
              text          { 'tab2 name' }
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('other') }
            end
            home_tab do
              text          { 'tab3 name' }
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('con') }
            end
          end
        end
      }
    }
    it 'should raise an error' do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::TabNameError)
    end
  end

  context 'with an unknown declaration' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          forks
        end
      }
    }
    it "should raise an error" do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::UnknownDeclarationError)
    end
  end

end

