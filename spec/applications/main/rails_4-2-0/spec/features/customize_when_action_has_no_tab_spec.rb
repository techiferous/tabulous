require 'spec_helper'

describe 'when_action_has_no_tab' do

  include TabHelpers

  def init(behavior)
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
          when_action_has_no_tab :#{behavior}
        end

      end
    }
  end

  context 'when set to :raise_error' do
    before(:each) { init(:raise_error) }
    context 'visiting a route that has no controller action listed in tabulous' do
      it 'should raise an error' do
        expect{ visit '/notabs' }.to raise_error(ActionView::Template::Error)
      end
    end
  end

  context 'when set to :render' do
    before(:each) { init(:render) }
    context 'visiting a route that has no controller action listed in tabulous' do
      before(:each) { visit '/notabs' }
      it 'should add the tab navigation markup to the page' do
        expect(page).to have_css('.tabs')
        expect(visible_tabs).to match_array( %w( Explanation Galaxies Stars Planets Subtabs ) )
      end
    end
  end

  context 'when set to :do_not_render' do
    before(:each) { init(:do_not_render) }
    context 'visiting a route that has no controller action listed in tabulous' do
      before(:each) { visit '/notabs' }
      it 'should not add the tab navigation markup to the page' do
        expect(page).not_to have_css('.tabs')
        expect(visible_tabs).to be_empty
      end
    end
  end
end
