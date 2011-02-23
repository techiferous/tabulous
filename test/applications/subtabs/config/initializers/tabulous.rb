Tabulous.setup do |config|

  config.tabs = [
    #------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT    |    PATH           |    VISIBLE?    |    ENABLED?    #
    #------------------------------------------------------------------------------------------------#
    [    :galaxies_tab    ,    'Galaxies'      ,    '/galaxies'    ,    true        ,    true        ],
    [    :planets_tab     ,    'Planets'       ,    '/planets'     ,    true        ,    true        ],
    [    :stars_tab       ,    'Stars'         ,    '/stars'       ,    true        ,    true        ],
    #------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT    |    PATH           |    VISIBLE?    |    ENABLED?    #
    #------------------------------------------------------------------------------------------------#
  ]

  config.actions = [
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
    [    :galaxies     ,    :all_actions    ,    :galaxies_tab    ],
    [    :planets      ,    :all_actions    ,    :planets_tab     ],
    [    :stars        ,    :all_actions    ,    :stars_tab       ],
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
  ]
  
  config.css.scaffolding = true

end
