Tabulous.setup do |config|

  config.tabs = [
    #---------------------------------------------------------------------------#
    #    TAB NAME         |    PATH           |    VISIBLE?    |    ENABLED?    #
    #---------------------------------------------------------------------------#
    [    :galaxies_tab    ,    "/galaxies"    ,    true        ,    true        ],
    [    :stars_tab       ,    "/stars"       ,    true        ,    true        ],
    [    :planets_tab     ,    "/planets"     ,    true        ,    true        ],
    #---------------------------------------------------------------------------#
    #    TAB NAME         |    PATH           |    VISIBLE?    |    ENABLED?    #
    #---------------------------------------------------------------------------#
  ]

  config.actions = [
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
    [    :galaxies     ,    :all_actions    ,    :galaxies_tab    ],
    [    :stars        ,    :all_actions    ,    :stars_tab       ],
    [    :planets      ,    :all_actions    ,    :planets_tab     ],
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
  ]

end
