Tabulous.setup do |config|

  config.tabs = [
    #------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT    |    PATH           |    VISIBLE?    |    ENABLED?    #
    #------------------------------------------------------------------------------------------------#
    [    :galaxies_tab    ,    'Galaxies'      ,    "/galaxies"    ,    true        ,    true        ],
    [    :stars_tab       ,    'Stars'         ,    "/stars"       ,    true        ,    true        ],
    [    :planets_tab     ,    'Planets'       ,    "/planets"     ,    true        ,    true        ],
    #------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT    |    PATH           |    VISIBLE?    |    ENABLED?    #
    #------------------------------------------------------------------------------------------------#
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

  config.css.scaffolding = true
  config.css.background_color = '#cec'
  config.css.inactive_tab_color = '#aca'
  config.css.hover_tab_color = '#dfd'

end
