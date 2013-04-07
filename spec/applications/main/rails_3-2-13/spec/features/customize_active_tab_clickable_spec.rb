require 'spec_helper'

describe 'active_tab_clickable' do

  include TabHelpers

  def init(active_tab_clickable)
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
            active_when   { in_action('any').of_controller('galaxies') }
          end

          stars_tab do
            text          'Stars'
            link_path     { stars_path }
            visible_when  { true }
            enabled_when  { true }
            active_when   { in_action('any').of_controller('stars') }
          end

          planets_tab do
            text          'Planets'
            link_path     { planets_path }
            visible_when  { true }
            enabled_when  { true }
            active_when   { in_action('any').of_controller('planets') }
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
            active_when   { in_action('two').of_controller('subtabs') }
          end

          three_subtab do
            text          'Three'
            link_path     '/subtabs/three'
            visible_when  { true }
            enabled_when  { true }
            active_when   { in_action('three').of_controller('subtabs') }
          end
        end

        customize do
          active_tab_clickable #{active_tab_clickable}
        end

      end
    }
    visit '/'
  end

  context 'when true' do
    before(:each) { init(true) }
    it 'should allow the active tab to be clickable' do
      click_link 'Galaxies'
      active_tab.should == 'Galaxies'
      'Galaxies'.should be_clickable
      click_link 'Subtabs'
      active_tab.should == 'Subtabs'
      'Subtabs'.should be_clickable
    end
  end

  context 'when false' do
    before(:each) { init(false) }
    it 'should not allow the active tab to be clickable' do
      click_link 'Galaxies'
      active_tab.should == 'Galaxies'
      'Galaxies'.should_not be_clickable
      click_link 'Subtabs'
      active_tab.should == 'Subtabs'
      'Subtabs'.should_not be_clickable
    end
  end

end
