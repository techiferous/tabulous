require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class AlwaysRenderSubtabsTest < ActionController::IntegrationTest

  def init(always_render_subtabs)
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

        config.always_render_subtabs = #{always_render_subtabs}

      end
    }
  end

  def assert_subtabs
    assert page.has_css?('#subtabs')
  end

  def assert_no_subtabs
    assert !page.has_css?('#subtabs')
  end

  test "always render subtabs" do
    init(true)
    visit '/'
    assert_subtabs
    click_link 'Galaxies'
    assert_subtabs
    click_link 'Stars'
    assert_subtabs
    click_link 'Planets'
    assert_subtabs
    click_link 'Subtabs'
    assert_subtabs
  end

  test "don't always render subtabs" do
    init(false)
    visit '/'
    assert_no_subtabs
    click_link 'Galaxies'
    assert_no_subtabs
    click_link 'Stars'
    assert_no_subtabs
    click_link 'Planets'
    assert_no_subtabs
    click_link 'Subtabs'
    assert_subtabs
  end

end
