require 'spec_helper'

describe 'css scaffolding' do

  include TabHelpers

  context 'when absent' do
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

        end
      }
      visit '/'
    end

    it 'should not prevent the app from working' do
      active_tab.should == 'Explanation'
      click_link 'Galaxies'
      page.should have_content('Listing Galaxies')
      active_tab.should == 'Galaxies'
      click_link 'Planets'
      page.should have_content('Listing Planets')
      active_tab.should == 'Planets'
    end
  end

  context 'when present' do
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

          use_css_scaffolding do
            background_color '#000'
            text_color '#111'
            active_tab_color '#222'
            hover_tab_color '#333'
            inactive_tab_color 'red'
            inactive_text_color 'blue'
          end

        end
      }
      visit '/'
    end

    describe 'css scaffolding colors' do
      it 'should be set' do
        # the scaffolding styles are not really a core part of the value of tabulous so we
        # only test that we can set the colors; we don't actually test that the colors
        # are used
        Tabulous::Config.background_color.should == '#000'
        Tabulous::Config.text_color.should == '#111'
        Tabulous::Config.active_tab_color.should == '#222'
        Tabulous::Config.hover_tab_color.should == '#333'
        Tabulous::Config.inactive_tab_color.should == 'red'
        Tabulous::Config.inactive_text_color.should == 'blue'
      end
    end
  end

end
