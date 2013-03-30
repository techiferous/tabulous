require 'spec_helper'

describe 'config.when_action_has_no_tab' do

  include TabHelpers

  def init(behavior)
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?    #
            #------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true        ,    true        ],
            [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true        ,    true        ],
            [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    true        ,    true        ],
            [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    true        ,    true        ],
            [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    true        ,    true        ],
            [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    true        ,    true        ],
            #------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?    #
            #------------------------------------------------------------------------------------------------------#
          ]
        end

        config.actions do
          [
            #-------------------------------------------------------------#
            #    CONTROLLER    |    ACTION          |    TAB              #
            #-------------------------------------------------------------#
            [    :home         ,    :all_actions    ,    :home_tab        ],
            [    :galaxies     ,    :all_actions    ,    :galaxies_tab    ],
            [    :stars        ,    :all_actions    ,    :stars_tab       ],
            [    :planets      ,    :all_actions    ,    :planets_tab     ],
            [    :subtabs      ,    :one            ,    :one_subtab      ],
            [    :subtabs      ,    :two            ,    :two_subtab      ],
            [    :subtabs      ,    :three          ,    :three_subtab    ],
            #-------------------------------------------------------------#
            #    CONTROLLER    |    ACTION          |    TAB              #
            #-------------------------------------------------------------#
          ]
        end

        config.when_action_has_no_tab = :#{behavior}

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
        page.should have_css('#tabs')
        visible_tabs.should match_array( %w( Explanation Galaxies Stars Planets Subtabs ) )
      end
    end
  end

  context 'when set to :do_not_render' do
    before(:each) { init(:do_not_render) }
    context 'visiting a route that has no controller action listed in tabulous' do
      before(:each) { visit '/notabs' }
      it 'should not add the tab navigation markup to the page' do
        page.should_not have_css('#tabs')
        visible_tabs.should be_empty
      end
    end
  end

end
