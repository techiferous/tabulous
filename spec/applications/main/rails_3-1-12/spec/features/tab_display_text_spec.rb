require 'spec_helper'

describe 'a tab' do

  include TabHelpers

  before(:each) do
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #-------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT                  |    PATH                |    VISIBLE?    |    ENABLED?    #
            #-------------------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'                 ,    "/"                 ,    true        ,    true        ],
            [    :galaxies_tab    ,    'foo'+'bar'                   ,    "/galaxies"         ,    true        ,    true        ],
            [    :stars_tab       ,    'Stars'                       ,    "/stars"            ,    true        ,    true        ],
            [    :planets_tab     ,    'Asteroids'                   ,    "/planets"          ,    true        ,    true        ],
            [    :subtabs_tab     ,    'Subtabs'                     ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :one_subtab      ,    'One'                         ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :two_subtab      ,    controller_name+'42'          ,    "/subtabs/two"      ,    true        ,    true        ],
            [    :three_subtab    ,    'Three'                       ,    "/subtabs/three"    ,    true        ,    true        ],
            #-------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT                  |    PATH                |    VISIBLE?    |    ENABLED?    #
            #-------------------------------------------------------------------------------------------------------------------#
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

      end
    }
    visit '/'
  end

  it 'can be assigned display text' do
    visible_tabs.should include('Asteroids')
    visible_tabs.should_not include('Planets')
  end
  it 'can be assigned display text dynamically' do
    visible_tabs.should include('foobar')
    visible_tabs.should_not include('Galaxies')
  end

  context 'that is a subtab' do
    before(:each) do
      click_link 'Subtabs'
    end
    it 'can be assigned display text' do
      visible_subtabs.should include('One')
      visible_subtabs.should include('Three')
    end
    it 'can be assigned display text dynamically' do
      visible_subtabs.should include('subtabs42')
    end
  end

end
