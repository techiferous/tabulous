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
    expect(visible_tabs).to include('Explanation')
    expect(visible_tabs).to include('Galaxies')
    expect(visible_tabs).to include('Subtabs')
    # hidden
    expect(visible_tabs).not_to include('Planets')
  end

  it 'can be hidden dynamically' do
    expect(visible_tabs).not_to include('Stars')
    click_link 'Galaxies'
    expect(visible_tabs).to include('Stars')
    click_link 'Stars'
    expect(visible_tabs).to include('Stars')
    click_link 'Subtabs'
    expect(visible_tabs).to include('Stars')
  end

  context 'that is a subtab' do
    it 'can be hidden' do
      click_link 'Subtabs'
      expect(visible_subtabs).to include('One')
      expect(visible_subtabs).not_to include('Two')
    end

    it 'can be hidden dynamically' do
      click_link 'Subtabs'
      expect(visible_subtabs).not_to include('Three')
    end
  end

end
