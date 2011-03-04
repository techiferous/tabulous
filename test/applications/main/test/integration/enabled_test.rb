require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class EnabledTest < ActionController::IntegrationTest

  def setup
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs = [
          #-------------------------------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?                             #
          #-------------------------------------------------------------------------------------------------------------------------------#
          [    :home_tab        ,    'Explanation'    ,    "/"                 ,    true        ,    true                                 ],
          [    :galaxies_tab    ,    'Galaxies'       ,    "/galaxies"         ,    true        ,    true                                 ],
          [    :stars_tab       ,    'Stars'          ,    "/stars"            ,    true        ,    lambda { controller_name =~ /t/ }    ],
          [    :planets_tab     ,    'Planets'        ,    "/planets"          ,    true        ,    false                                ],
          [    :subtabs_tab     ,    'Subtabs'        ,    "/subtabs/one"      ,    true        ,    true                                 ],
          [    :one_subtab      ,    'One'            ,    "/subtabs/one"      ,    true        ,    true                                 ],
          [    :two_subtab      ,    'Two'            ,    "/subtabs/two"      ,    true        ,    false                                ],
          [    :three_subtab    ,    'Three'          ,    "/subtabs/three"    ,    true        ,    lambda { true }                      ],
          #-------------------------------------------------------------------------------------------------------------------------------#
          #    TAB NAME         |    DISPLAY TEXT     |    PATH                |    VISIBLE?    |    ENABLED?                             #
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

  test "disabling tabs" do
    visit '/'
    assert_tab_enabled 'Explanation'
    assert_tab_enabled 'Galaxies'
    assert_tab_disabled 'Planets'
    assert_tab_enabled 'Subtabs'
  end
 
  test "dynamically disabling tabs" do
    visit '/'
    assert_tab_disabled 'Stars'
    click_link 'Galaxies'
    assert_tab_disabled 'Stars'
    click_link 'Subtabs'
    assert_tab_enabled 'Stars'
    click_link 'Stars'
    assert_tab_enabled 'Stars'
  end
 
  test "disabling subtabs" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_enabled 'One'
    assert_subtab_disabled 'Two'
  end
 
  test "dynamically disabling subtabs" do
    visit '/'
    click_link 'Subtabs'
    assert_subtab_enabled 'Three'
  end
 
end
