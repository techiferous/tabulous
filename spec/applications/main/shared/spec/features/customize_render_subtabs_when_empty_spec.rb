require 'spec_helper'

describe 'render_subtabs_when_empty' do

  include TabHelpers

  def init(render_subtabs_when_empty)
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
          render_subtabs_when_empty #{render_subtabs_when_empty}
        end

      end
    }
    visit '/'
  end

  context 'when true' do
    before(:each) { init(true) }
    it 'should always include subtabs in the markup' do
      subtabs_should_be_present
      click_link 'Galaxies'
      subtabs_should_be_present
      click_link 'Stars'
      subtabs_should_be_present
      click_link 'Planets'
      subtabs_should_be_present
      click_link 'Subtabs'
      subtabs_should_be_present
    end
  end

  context 'when false' do
    before(:each) { init(false) }
    it 'should only include subtabs in the markup if that particular tab has subtabs' do
      subtabs_should_not_be_present
      click_link 'Galaxies'
      subtabs_should_not_be_present
      click_link 'Stars'
      subtabs_should_not_be_present
      click_link 'Planets'
      subtabs_should_not_be_present
      click_link 'Subtabs'
      subtabs_should_be_present
    end
  end

end
