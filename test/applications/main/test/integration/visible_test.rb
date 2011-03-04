require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class VisibleTest < ActionController::IntegrationTest

  def setup
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs = [
          #-------------------------------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?                             |    ENABLED?    #
          #-------------------------------------------------------------------------------------------------------------------------------#
          [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true                                 ,    true        ],
          [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true                                 ,    true        ],
          [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    lambda { controller_name =~ /s/ }    ,    true        ],
          [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    false                                ,    true        ],
          [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true                                 ,    true        ],
          [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true                                 ,    true        ],
          [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    false                                ,    true        ],
          [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    lambda { false }                     ,    true        ],
          #-------------------------------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?                             |    ENABLED?    #
          #-------------------------------------------------------------------------------------------------------------------------------#
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

        config.css.scaffolding = true

      end
    }
  end

  test "tab visibility" do
    visit '/'
    assert_tab_present 'Explanation'
    assert_tab_present 'Galaxies'
    assert_tab_not_present 'Planets'
    assert_tab_present 'Subtabs'
  end
 
  test "dynamic tab visibility" do
    visit '/'
    assert_tab_not_present 'Stars'
    click_link 'Galaxies'
    assert_tab_present 'Stars'
    click_link 'Stars'
    assert_tab_present 'Stars'
    click_link 'Subtabs'
    assert_tab_present 'Stars'
  end
 
  test "subtab visibility" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_present 'One'
    assert_subtab_not_present 'Two'
  end
 
  test "dynamic subtab visibility" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_not_present 'Three'
  end
 
end
