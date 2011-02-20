Tabulous.setup do |config|

  config.tabs = [
    #-------------------------------------------------------------#
    #    TAB NAME         |    PATH           |    AUTHORIZED?    #
    #-------------------------------------------------------------#
    [    :galaxies_tab    ,    "/galaxies"    ,    true           ],
    [    :stars_tab       ,    "/stars"       ,    true           ],
    [    :planets_tab     ,    "/planets"     ,    true           ],
    #-------------------------------------------------------------#
    #    TAB NAME         |    PATH           |    AUTHORIZED?    #
    #-------------------------------------------------------------#
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
