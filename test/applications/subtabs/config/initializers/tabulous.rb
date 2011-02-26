Tabulous.setup do |config|

  config.tabs = [
    #-------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------#
    [    :home_tab        ,    'Explanation'    ,    '/'            ,    true        ,    true        ],
    [    :galaxies_tab    ,    'Galaxies'       ,    '/galaxies'    ,    true        ,    true        ],
    [    :planets_tab     ,    'Planets'        ,    '/planets'     ,    true        ,    true        ],
    [    :stars_tab       ,    'Stars'          ,    '/stars'       ,    true        ,    true        ],
    #-------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------#
  ]

  config.actions = [
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
    [    :home         ,    :all_actions    ,    :home_tab        ],
    [    :galaxies     ,    :all_actions    ,    :galaxies_tab    ],
    [    :planets      ,    :all_actions    ,    :planets_tab     ],
    [    :stars        ,    :all_actions    ,    :stars_tab       ],
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
  ]
  
  config.css.scaffolding = true
  config.css.background_color = '#cec'
  config.css.text_color = '#464'
  config.css.active_tab_color = '#fff'
  config.css.hover_tab_color = '#dfd'
  config.css.inactive_tab_color = '#aca'

end
