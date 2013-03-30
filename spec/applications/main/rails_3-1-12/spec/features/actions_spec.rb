require 'spec_helper'

describe 'an action' do

  include TabHelpers

  before(:each) do
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
    visit '/'
  end

  context 'specified explicitly' do
    context 'when visiting that action' do
      before(:each) { visit '/' }
      it 'should render the view associated with that action' do
        page.should have_content('This tests tabulous in all sorts of configurations.')
      end
      it 'should activate the tab associated with that action' do
        active_tab.should == 'Explanation'
      end
    end
  end

  context 'specified using :all_actions' do
    context 'when visiting index' do
      before(:each) { click_link 'Galaxies' }
      it 'should render the view associated with that action' do
        page.should have_content('Listing galaxies')
      end
      it 'should activate the tab associated with that action' do
        active_tab.should == 'Galaxies'
      end
    end

    context 'when visiting new' do
      before(:each) { click_link 'Galaxies'; click_link 'New Galaxy' }
      it 'should render the view associated with that action' do
        page.should have_content('New galaxy')
      end
      it 'should activate the tab associated with that action' do
        active_tab.should == 'Galaxies'
      end
    end
  end

  context 'associated with a subtab' do
    context 'specified explicitly' do
      context 'when visiting that action' do
        before(:each) { click_link 'Subtabs'; click_link 'Two' }
        it 'should render the view associated with that action' do
          page.should have_content('Subtab #2')
        end
        it 'should activate the tab and subtab associated with that action' do
          active_tab.should == 'Subtabs'
          active_subtab.should == 'Two'
        end
      end
    end
  end
end
