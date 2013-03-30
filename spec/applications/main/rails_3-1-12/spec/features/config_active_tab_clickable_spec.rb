require 'spec_helper'

describe 'config.active_tab_clickable' do

  include TabHelpers

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
    visit '/'
  end

  context 'when true' do
    before(:each) { init(true) }
    it 'should allow the active tab to be clickable' do
      click_link 'Galaxies'
      active_tab.should == 'Galaxies'
      'Galaxies'.should be_clickable
      click_link 'Subtabs'
      active_tab.should == 'Subtabs'
      'Subtabs'.should be_clickable
    end
  end

  context 'when false' do
    before(:each) { init(false) }
    it 'should not allow the active tab to be clickable' do
      click_link 'Galaxies'
      active_tab.should == 'Galaxies'
      'Galaxies'.should_not be_clickable
      click_link 'Subtabs'
      active_tab.should == 'Subtabs'
      'Subtabs'.should_not be_clickable
    end
  end

end
