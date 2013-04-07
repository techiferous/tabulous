require 'spec_helper'

describe 'a tab' do

  include TabHelpers

  context 'with valid active_when declarations' do
    before(:each) do
      use_tab_file %Q{
        Tabulous.setup do

          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end

            galaxies_tab do
              text          'Galaxies'
              link_path     { galaxies_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('planets') }
            end

            stars_tab do
              text          'Stars'
              link_path     { stars_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('index').of_controller('stars') }
            end

            planets_tab do
              text          'Planets'
              link_path     { planets_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_actions('index', 'new').of_controller('galaxies') }
            end

            subtabs_tab do
              text          'Subtabs'
              link_path     '/subtabs/one'
              visible_when  { true }
              enabled_when  { true }
              active_when   { a_subtab_is_active }
            end

            one_subtab do
              text          'One'
              link_path     '/subtabs/one'
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('one').of_controller('subtabs') }
            end

            two_subtab do
              text          'Two'
              link_path     '/subtabs/two'
              visible_when  { true }
              enabled_when  { true }
              active_when do
                in_action('two').of_controller('subtabs')
                in_action('three').of_controller('subtabs')
              end
            end

            three_subtab do
              text          'Three'
              link_path     '/subtabs/three'
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('none').of_controller('subtabs') }
            end
          end

        end
      }
      visit '/'
    end

    context 'not specified' do
      context 'when visiting that implied action' do
        before(:each) { visit '/' }
        it 'should render the view associated with that action' do
          page.should have_content('This tests tabulous in all sorts of configurations.')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Explanation'
        end
      end
    end

    context 'specified explicitly' do
      context 'when visiting that action' do
        before(:each) { click_link 'Stars' }
        it 'should render the view associated with that action' do
          page.should have_content('Listing stars')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Stars'
        end
      end
    end

    context 'specified using :any' do
      context 'when visiting an action' do
        before(:each) { click_link 'Galaxies' }
        it 'should render the view associated with that action' do
          page.should have_content('Listing galaxies')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Planets'
        end
      end
      context 'when visiting another action' do
        before(:each) do
          click_link 'Galaxies'
          click_link 'New Galaxy'
        end
        it 'should render the view associated with that action' do
          page.should have_content('New galaxy')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Planets'
        end
      end
    end

    context 'multiple actions specified' do
      context 'when visiting the first action' do
        before(:each) { click_link 'Planets' }
        it 'should render the view associated with that action' do
          page.should have_content('Listing planets')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Galaxies'
        end
      end
      context 'when visiting the second action' do
        before(:each) do
          click_link 'Planets'
          click_link 'New Planet'
        end
        it 'should render the view associated with that action' do
          page.should have_content('New planet')
        end
        it 'should activate the tab associated with that action' do
          active_tab.should == 'Galaxies'
        end
      end
    end

    context 'multiple declarations' do
      context 'when visiting the first action' do
        before(:each) do
          click_link 'Subtabs'
          click_link 'Two'
        end
        it 'should render the view associated with that action' do
          page.should have_content('Subtab #2')
        end
        it 'should activate the subtab associated with that action' do
          active_subtab.should == 'Two'
        end
      end
      context 'when visiting the second action' do
        before(:each) do
          click_link 'Subtabs'
          click_link 'Three'
        end
        it 'should render the view associated with that action' do
          page.should have_content('Subtab #3')
        end
        it 'should activate the subtab associated with that action' do
          active_subtab.should == 'Two'
        end
      end
    end
  end

  context 'with an unknown declaration' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { bork }
            end
          end
        end
      }
    }
    it 'should raise an error' do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::UnknownDeclarationError)
    end
  end

  context 'with conflicting active_when declarations' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('index').of_controller('home') }
            end

            galaxies_tab do
              text          'Galaxies'
              link_path     { galaxies_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end
          end
        end
      }
    }
    it 'should raise an error' do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::AmbiguousActiveTabRulesError)
    end
  end

  context 'missing a_subtab_is_active declaration' do
    let(:tab_file) {
      %Q{
        Tabulous.setup do
          tabs do
            home_tab do
              text          'Explanation'
              link_path     { root_path }
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('any').of_controller('home') }
            end

            subtabs_tab do
              text          'Subtabs'
              link_path     '/subtabs/one'
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('two').of_controller('subtabs') }
            end

            one_subtab do
              text          'One'
              link_path     '/subtabs/one'
              visible_when  { true }
              enabled_when  { true }
              active_when   { in_action('one').of_controller('subtabs') }
            end
          end
        end
      }
    }
    it 'should raise an error' do
      expect { use_tab_file(tab_file) }.to raise_error(Tabulous::MissingActiveTabRuleError)
    end
  end
end
