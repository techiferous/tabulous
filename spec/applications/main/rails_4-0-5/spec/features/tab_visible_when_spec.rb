require 'spec_helper'

describe 'a tab' do

  include TabHelpers

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
            active_when   { in_action('any').of_controller('galaxies') }
          end

          stars_tab do
            text          'Stars'
            link_path     { stars_path }
            visible_when  { controller_name =~ /s/ }
            enabled_when  { true }
            active_when   { in_action('any').of_controller('stars') }
          end

          planets_tab do
            text          'Planets'
            link_path     { planets_path }
            visible_when  false
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
            visible_when  false
            enabled_when  { true }
            active_when   { in_action('two').of_controller('subtabs') }
          end

          three_subtab do
            text          'Three'
            link_path     '/subtabs/three'
            visible_when  { !true }
            enabled_when  { true }
            active_when   { in_action('three').of_controller('subtabs') }
          end
        end

      end
    }
    visit '/'
  end

  it 'can be hidden' do
    # visible
    visible_tabs.should include('Explanation')
    visible_tabs.should include('Galaxies')
    visible_tabs.should include('Subtabs')
    # hidden
    visible_tabs.should_not include('Planets')
  end

  it 'can be hidden dynamically' do
    visible_tabs.should_not include('Stars')
    click_link 'Galaxies'
    visible_tabs.should include('Stars')
    click_link 'Stars'
    visible_tabs.should include('Stars')
    click_link 'Subtabs'
    visible_tabs.should include('Stars')
  end

  context 'that is a subtab' do
    it 'can be hidden' do
      click_link 'Subtabs'
      visible_subtabs.should include('One')
      visible_subtabs.should_not include('Two')
    end

    it 'can be hidden dynamically' do
      click_link 'Subtabs'
      visible_subtabs.should_not include('Three')
    end
  end

end
