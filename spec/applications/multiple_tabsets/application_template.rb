require File.expand_path('../../application_template_helper', __FILE__)

generate_test_application do

  #*****************************************************************************
  #  MODELS AND SCAFFOLDING

  generate(:scaffold, 'galaxies/elliptical_galaxy name:string --old-style-hash')
  generate(:scaffold, 'galaxies/lenticular_galaxy name:string --old-style-hash')
  generate(:scaffold, 'galaxies/spiral_galaxy name:string --old-style-hash')
  generate(:scaffold, 'planets/exoplanet name:string --old-style-hash')
  generate(:scaffold, 'planets/rogue_planet name:string --old-style-hash')

  #*****************************************************************************
  #  MORE CONTROLLERS AND VIEWS

  generate(:controller, 'home index --old-style-hash')
  replace_view 'home', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This application is useful for testing multiple tab sets.
    <ul>
      <li><a href="/galaxies/elliptical_galaxies">tab set one</a></li>
      <li><a href="/planets/exoplanets">tab set two</a></li>
    </ul>
  CODE

  #*****************************************************************************
  #  MORE ROUTES

  route "root :to => 'home#index'"

  #*****************************************************************************
  #  LAYOUT

  replace_application_layout <<-CODE.strip_heredoc
    <!DOCTYPE html>
    <html>
    <head>
      <title>Multiple Tabsets</title>
      <%= csrf_meta_tag %>
    </head>
    <body>
      <%= tabs(:galaxies) %>
      <%= tabs(:planets) %>
      <%= yield %>
    </body>
    </html>
  CODE

end
