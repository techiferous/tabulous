require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class DisplayTextTest < ActionController::IntegrationTest

  def setup
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
            #-------------------------------------------------------------------------------------------------------------------#
            #    TAB NAME         |    DISPLAY TEXT                  |    PATH                |    VISIBLE?    |    ENABLED?    #
            #-------------------------------------------------------------------------------------------------------------------#
            [    :home_tab        ,    'Explanation'                 ,    "/"                 ,    true        ,    true        ],
            [    :galaxies_tab    ,    'Galaxies'                    ,    "/galaxies"         ,    true        ,    true        ],
            [    :stars_tab       ,    'Stars'                       ,    "/stars"            ,    true        ,    true        ],
            [    :planets_tab     ,    'Asteroids'                   ,    "/planets"          ,    true        ,    true        ],
            [    :subtabs_tab     ,    'Subtabs'                     ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :one_subtab      ,    'One'                         ,    "/subtabs/one"      ,    true        ,    true        ],
            [    :two_subtab      ,    controller_name               ,    "/subtabs/two"      ,    true        ,    true        ],
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
  end

  test "tab display text" do
    visit '/'
    assert_tab_not_present 'Planets'
    assert_tab_present 'Asteroids'
  end
  
  test "dynamic tab display text" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_present 'subtabs'
  end
 
  test "subtab display text" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_present 'One'
    assert_subtab_present 'Three'
  end
  
  test "dynamic subtab display text" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_present 'subtabs'
  end
  
end
