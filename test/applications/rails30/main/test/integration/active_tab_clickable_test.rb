require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class ActiveTabClickableTest < ActionController::IntegrationTest

  def init(active_tab_clickable)
    use_tab_file %Q{
      Tabulous.setup do |config|

        config.tabs do
          [
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

        config.active_tab_clickable = #{active_tab_clickable}

      end
    }
  end

  def assert_tab_clickable(text)
    result = page.all('#tabs li a', :text => text)
    assert !result.empty?
  end

  def assert_tab_not_clickable(text)
    link = page.all('#tabs li a', :text => text)
    span = page.all('#tabs li span', :text => text)
    assert !span.empty?
    assert link.empty?
  end

  test "active tab clickable" do
    init(true)
    visit '/'
    assert_tab_active 'Explanation'
    assert_tab_clickable 'Explanation'
    click_link 'Galaxies'
    assert_tab_active 'Galaxies'
    assert_tab_clickable 'Galaxies'
    click_link 'Subtabs'
    assert_tab_active 'Subtabs'
    assert_tab_clickable 'Subtabs'
  end

  test "active tab not clickable" do
    init(false)
    visit '/'
    assert_tab_active 'Explanation'
    assert_tab_not_clickable 'Explanation'
    click_link 'Galaxies'
    assert_tab_active 'Galaxies'
    assert_tab_not_clickable 'Galaxies'
    click_link 'Subtabs'
    assert_tab_active 'Subtabs'
    assert_tab_not_clickable 'Subtabs'
  end

end
