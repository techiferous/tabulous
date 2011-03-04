require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class ActionsTest < ActionController::IntegrationTest

  def setup
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
            [    :home         ,    :index          ,    :home_tab        ],
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

  test "tab actions" do
    visit '/'
    assert page.has_content?('This tests tabulous in all sorts of configurations.')
    assert_tab_active 'Explanation'
    click_link 'Galaxies'
    assert page.has_content?('Listing galaxies')
    assert_tab_active 'Galaxies'
    click_link 'New Galaxy'
    assert page.has_content?('New galaxy')
    assert_tab_active 'Galaxies'
    click_link 'Planets'
    assert page.has_content?('Listing planets')
    assert_tab_active 'Planets'
  end

  test "subtab actions" do
    visit '/'
    click_link 'Subtabs'
    assert page.has_content?('Subtab #1')
    assert_tab_active 'Subtabs'
    assert_subtab_active 'One'
    click_link 'Two'
    assert page.has_content?('Subtab #2')
    assert_tab_active 'Subtabs'
    assert_subtab_active 'Two'
    click_link 'Three'
    assert page.has_content?('Subtab #3')
    assert_tab_active 'Subtabs'
    assert_subtab_active 'Three'
  end

end
