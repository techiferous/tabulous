require 'spec_helper'

describe 'a tab' do

  include TabHelpers

  before(:each) do
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #-------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?                             #
            #-------------------------------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true        ,    true                                 ],
            [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true        ,    true                                 ],
            [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    true        ,    controller_name =~ /t/               ],
            [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    true        ,    false                                ],
            [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true        ,    true                                 ],
            [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true        ,    true                                 ],
            [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    true        ,    false                                ],
            [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    true        ,    5 == 5                               ],
            #-------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?                             #
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

  it 'can be disabled' do
    # enabled
    enabled_tabs.should include('Explanation')
    enabled_tabs.should include('Galaxies')
    enabled_tabs.should include('Subtabs')
    # disabled
    disabled_tabs.should include('Planets')
  end

  it 'can be disabled dynamically' do
    disabled_tabs.should include('Stars')
    click_link 'Galaxies'
    disabled_tabs.should include('Stars')
    click_link 'Subtabs'
    enabled_tabs.should include('Stars')
    click_link 'Stars'
    enabled_tabs.should include('Stars')
  end

  context 'that is a subtab' do
    it 'can be disabled' do
      click_link 'Subtabs'
      enabled_subtabs.should include('One')
      disabled_subtabs.should include('Two')
    end

    it 'can be disabled dynamically' do
      click_link 'Subtabs'
      enabled_subtabs.should include('Three')
    end
  end

end
