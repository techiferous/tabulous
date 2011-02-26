Tabulous.setup do |config|

  config.tabs = [
    #-------------------------------------------------------------------------------------------------------------------------------------------#
    #    TAB NAME                       |    DISPLAY TEXT             |    PATH                               |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------------------------------------------------#
    [    :home_tab                      ,    'Explanation'            ,    '/'                                ,    true        ,    true        ],
    [    :galaxies_tab                  ,    'Galaxies'               ,    '/galaxies/elliptical_galaxies'    ,    true        ,    true        ],
    [    :elliptical_galaxies_subtab    ,    'Elliptical Galaxies'    ,    '/galaxies/elliptical_galaxies'    ,    true        ,    true        ],
    [    :spiral_galaxies_subtab        ,    'Spiral Galaxies'        ,    '/galaxies/spiral_galaxies'        ,    true        ,    true        ],
    [    :lenticular_galaxies_subtab    ,    'Lenticular Galaxies'    ,    '/galaxies/lenticular_galaxies'    ,    true        ,    true        ],
    [    :planets_tab                   ,    'Planets'                ,    '/exoplanets'                      ,    true        ,    true        ],
    [    :exoplanets_subtab             ,    'Exoplanets'             ,    '/exoplanets'                      ,    true        ,    true        ],
    [    :rogue_planets_subtab          ,    'Rogue Planets'          ,    '/rogue_planets'                   ,    true        ,    true        ],
    [    :stars_tab                     ,    'Stars'                  ,    '/stars'                           ,    true        ,    true        ],
    #-------------------------------------------------------------------------------------------------------------------------------------------#
    #    TAB NAME                       |    DISPLAY TEXT             |    PATH                               |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------------------------------------------------#
  ]

  config.actions = [
    #-------------------------------------------------------------------------------------#
    #    CONTROLLER              |    ACTION          |    TAB                            #
    #-------------------------------------------------------------------------------------#
    [    :home                   ,    :all_actions    ,    :home_tab                      ],
    [    :elliptical_galaxies    ,    :all_actions    ,    :elliptical_galaxies_subtab    ],
    [    :spiral_galaxies        ,    :all_actions    ,    :spiral_galaxies_subtab        ],
    [    :lenticular_galaxies    ,    :all_actions    ,    :lenticular_galaxies_subtab    ],
    [    :exoplanets             ,    :all_actions    ,    :exoplanets_subtab             ],
    [    :rogue_planets          ,    :all_actions    ,    :rogue_planets_subtab          ],
    [    :stars                  ,    :all_actions    ,    :stars_tab                     ],
    #-------------------------------------------------------------------------------------#
    #    CONTROLLER              |    ACTION          |    TAB                            #
    #-------------------------------------------------------------------------------------#
  ]
  
  config.css.scaffolding = true
  config.css.background_color = '#cec'
  config.css.text_color = '#464'
  config.css.active_tab_color = '#fff'
  config.css.hover_tab_color = '#dfd'
  config.css.inactive_tab_color = '#aca'

end
