require 'spec_helper'

describe 'css scaffolding' do

  include TabHelpers

  context 'when absent' do
    before(:each) do
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

        end
      }
      visit '/'
    end

    it 'should not prevent the app from working' do
      active_tab.should == 'Explanation'
      click_link 'Galaxies'
      page.should have_content('Listing galaxies')
      active_tab.should == 'Galaxies'
      click_link 'Planets'
      page.should have_content('Listing planets')
      active_tab.should == 'Planets'
    end
  end

  context 'when present' do
    before(:each) do
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

          config.css.scaffolding = true
          config.css.background_color = '#000'
          config.css.text_color = '#111'
          config.css.active_tab_color = '#222'
          config.css.hover_tab_color = '#333'
          config.css.inactive_tab_color = 'red'
          config.css.inactive_text_color = 'blue'

        end
      }
      visit '/'
    end

    describe 'css scaffolding colors' do
      it 'should be set' do
        # the scaffolding styles are not really a core part of the value of tabulous so we
        # only test that we can set the colors; we don't actually test that the colors
        # are used
        Tabulous.css.background_color.should == '#000'
        Tabulous.css.text_color.should == '#111'
        Tabulous.css.active_tab_color.should == '#222'
        Tabulous.css.hover_tab_color.should == '#333'
        Tabulous.css.inactive_tab_color.should == 'red'
        Tabulous.css.inactive_text_color.should == 'blue'
      end
    end
  end

end
