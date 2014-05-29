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
            link_path     { controller_name == 'galaxies' ? "/stars" : "/planets" }
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
            link_path     { "/subtabs" + "/three" }
            visible_when  { true }
            enabled_when  { true }
            active_when   { in_action('three').of_controller('subtabs') }
          end
        end

      end
    }
    visit '/'
  end

  it 'can be be assigned a link path' do
    click_link 'Galaxies'
    page.should have_content('Listing galaxies')
    click_link 'Planets'
    page.should have_content('Listing planets')
  end

  it 'can be assigned a link path dynamically' do
    click_link 'Stars'
    page.should have_content('Listing planets')
    click_link 'Galaxies'
    click_link 'Stars'
    page.should have_content('Listing stars')
  end

  context 'that is a subtab' do
    it 'can be be assigned a link path' do
      click_link 'Subtabs'
      click_link 'Two'
      page.should have_content('Subtab #2')
      click_link 'One'
      page.should have_content('Subtab #1')
    end

    it 'can be assigned a link path dynamically' do
      visit '/'
      click_link 'Subtabs'
      click_link 'Three'
      page.should have_content('Subtab #3')
    end
  end

end
