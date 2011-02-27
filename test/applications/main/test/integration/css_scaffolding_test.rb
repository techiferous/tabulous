require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class CssScaffoldingTest < ActionController::IntegrationTest

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

        config.css.scaffolding = true
        config.css.background_color = '#000'
        config.css.text_color = '#111'
        config.css.active_tab_color = '#222'
        config.css.hover_tab_color = '#333'
        config.css.inactive_tab_color = 'red'
        config.css.inactive_text_color = 'blue'

      end
    }
  end

  test "css scaffolding colors" do
    # the scaffolding styles are not really a core part of the value of tabulous so we
    # only test that we can set the colors; we don't actually test that the colors
    # are used
    visit '/'
    assert_equal '#000', Tabulous.css.background_color
    assert_equal '#111', Tabulous.css.text_color
    assert_equal '#222', Tabulous.css.active_tab_color
    assert_equal '#333', Tabulous.css.hover_tab_color
    assert_equal 'red', Tabulous.css.inactive_tab_color
    assert_equal 'blue', Tabulous.css.inactive_text_color
  end

end
