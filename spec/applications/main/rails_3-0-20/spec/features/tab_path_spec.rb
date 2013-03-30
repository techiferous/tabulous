require 'spec_helper'

describe 'a tab' do

  include TabHelpers

  before(:each) do
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #------------------------------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                                                                |    VISIBLE?    |    ENABLED?    #
            #------------------------------------------------------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'    ,    "/"                                                                 ,    true        ,    true        ],
            [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"                                                         ,    true        ,    true        ],
            [    :stars_tab       ,    'Stars'          ,    controller_name == 'galaxies' ? "/stars" : "/planets"               ,    true        ,    true        ],
            [    :planets_tab     ,    'Planets'        ,    "/planets"                                                          ,    true        ,    true        ],
            [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"                                                      ,    true        ,    true        ],
            [    :one_subtab      ,    'One'            ,    "/subtabs/one"                                                      ,    true        ,    true        ],
            [    :two_subtab      ,    'Two'            ,    "/subtabs/two"                                                      ,    true        ,    true        ],
            [    :three_subtab    ,    'Three'          ,    "/subtabs" + "/three"                                               ,    true        ,    true        ],
            #------------------------------------------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT     |    PATH                                                                |    VISIBLE?    |    ENABLED?    #
            #------------------------------------------------------------------------------------------------------------------------------------------------------#
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

  it 'can be be assigned a path' do
    click_link 'Galaxies'
    page.should have_content('Listing galaxies')
    click_link 'Planets'
    page.should have_content('Listing planets')
  end

  it 'can be assigned a path dynamically' do
    click_link 'Stars'
    page.should have_content('Listing planets')
    click_link 'Galaxies'
    click_link 'Stars'
    page.should have_content('Listing stars')
  end

  context 'that is a subtab' do
    it 'can be be assigned a path' do
      click_link 'Subtabs'
      click_link 'Two'
      page.should have_content('Subtab #2')
      click_link 'One'
      page.should have_content('Subtab #1')
    end

    it 'can be assigned a path dynamically' do
      visit '/'
      click_link 'Subtabs'
      click_link 'Three'
      page.should have_content('Subtab #3')
    end
  end

end
