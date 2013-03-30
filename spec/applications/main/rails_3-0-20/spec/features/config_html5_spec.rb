require 'spec_helper'

describe 'config.html5' do

  include TabHelpers

  def init(html5)
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

        config.html5 = #{html5}

      end
    }
    visit '/'
  end

  context 'when true' do
    before(:each) { init(true) }
    it 'should have html5 markup' do
      page.should_not have_css('div#tabs')
      page.should have_css('nav#tabs')
      click_link 'Subtabs'
      page.should_not have_css('div#subtabs')
      page.should have_css('nav#subtabs')
    end
  end

  context 'when false' do
    before(:each) { init(false) }
    it 'should not have html5 markup' do
      page.should have_css('div#tabs')
      page.should_not have_css('nav#tabs')
      click_link 'Subtabs'
      page.should have_css('div#subtabs')
      page.should_not have_css('nav#subtabs')
    end
  end

end
