require 'spec_helper'

describe 'a tab' do

  include TabHelpers

  before(:each) do
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #-------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?                             |    ENABLED?    #
            #-------------------------------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true                                 ,    true        ],
            [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true                                 ,    true        ],
            [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    controller_name =~ /s/               ,    true        ],
            [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    false                                ,    true        ],
            [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true                                 ,    true        ],
            [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true                                 ,    true        ],
            [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    false                                ,    true        ],
            [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    !true                                ,    true        ],
            #-------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?                             |    ENABLED?    #
            #-------------------------------------------------------------------------------------------------------------------------------#
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
