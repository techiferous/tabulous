require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class CssNoScaffoldingTest < ActionController::IntegrationTest

  def setup
    use_initializer %Q{
      Tabulous.setup do |config|

        config.tabs = [
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

        config.actions = [
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
    }
  end

  test "works without css scaffolding" do
    visit '/'
    assert_tab_active 'Explanation'
    click_link 'Galaxies'
    assert page.has_content?('Listing galaxies')
    assert_tab_active 'Galaxies'
    click_link 'Planets'
    assert page.has_content?('Listing planets')
    assert_tab_active 'Planets'
  end

end
