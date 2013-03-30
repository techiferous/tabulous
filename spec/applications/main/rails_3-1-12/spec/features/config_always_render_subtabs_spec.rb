require 'spec_helper'

describe 'config.always_render_subtabs' do

  include TabHelpers

  def init(always_render_subtabs)
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

        config.always_render_subtabs = #{always_render_subtabs}

      end
    }
    visit '/'
  end

  context 'when true' do
    before(:each) { init(true) }
    it 'should always include subtabs in the markup' do
      subtabs_should_be_present
      click_link 'Galaxies'
      subtabs_should_be_present
      click_link 'Stars'
      subtabs_should_be_present
      click_link 'Planets'
      subtabs_should_be_present
      click_link 'Subtabs'
      subtabs_should_be_present
    end
  end

  context 'when false' do
    before(:each) { init(false) }
    it 'should only include subtabs in the markup if that particular tab has subtabs' do
      subtabs_should_not_be_present
      click_link 'Galaxies'
      subtabs_should_not_be_present
      click_link 'Stars'
      subtabs_should_not_be_present
      click_link 'Planets'
      subtabs_should_not_be_present
      click_link 'Subtabs'
      subtabs_should_be_present
    end
  end

end
