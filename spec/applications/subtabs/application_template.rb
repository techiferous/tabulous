require File.expand_path('../../application_template_helper', __FILE__)

generate_test_application do

  #*****************************************************************************
  #  MODELS AND SCAFFOLDING

  generate(:model, 'galaxy name:string')
  generate(:scaffold, 'galaxies/elliptical_galaxy name:string')
  generate(:scaffold, 'galaxies/lenticular_galaxy name:string')
  generate(:scaffold, 'galaxies/spiral_galaxy name:string')
  generate(:model, 'planet name:string')
  generate(:scaffold, 'exoplanet name:string')
  generate(:scaffold, 'rogue_planet name:string')
  generate(:scaffold, 'star name:string')

  #*****************************************************************************
  #  MORE CONTROLLERS AND VIEWS

  generate(:controller, 'home', 'index')
  replace_view 'home', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This application is useful for testing that:
    <ul>
      <li>tabs can have subtabs</li>
      <li>the scaffold styles work well with custom application styles (and a reset stylesheet)</li>
      <li>scaffold styles can be customized</li>
      <li>tabs work with namespaced resources</li>
      <li>tabs and subtabs can be hidden</li>
      <li>tabs and subtabs can be disabled</li>
      <li>tabs and controllers do not need a one-to-one mapping</li>
      <li>procs can be used in tab configuration</li>
    </ul>
  CODE

  generate(:controller, 'misc', 'always_hidden', 'always_visible', 'always_enabled', 'always_disabled')
  replace_view 'misc', 'always_enabled', <<-CODE.strip_heredoc
    <p>
      This subtab is always enabled.  The neighboring subtab, called "always disabled",
      should never be clickable.
    </p>
  CODE
  replace_view 'misc', 'always_visible', <<-CODE.strip_heredoc
    <p>
      This subtab is always visible.  The neighboring subtab, called "always hidden",
      should never be shown.
    </p>
  CODE

  #*****************************************************************************
  #  MORE ROUTES

  route "root to: 'home#index'"
  route "match 'hidden/always_visible' => 'misc#always_visible'"
  route "match 'hidden/always_hidden' => 'misc#always_hidden'"
  route "match 'disabled/always_enabled' => 'misc#always_enabled'"
  route "match 'disabled/always_disabled' => 'misc#always_disabled'"

  #*****************************************************************************
  #  LAYOUT

  replace_application_layout <<-CODE.strip_heredoc
    <!DOCTYPE html>
    <html>
    <head>
      <title>Subtabs</title>
      <%= stylesheet_link_tag 'reset' %>
      <%= stylesheet_link_tag 'application' %>
      <%= csrf_meta_tag %>
    </head>
    <body>
      <header id="main">
        <h1 id="title">Subtabs</h1>
        <h2 id="subtitle">Test Application for Tabulous</h2>
      </header>
      <%= tabs %>
      <%= subtabs %>
      <div id="content">
        <%= yield %>
      </div>
    </body>
    </html>
  CODE

end
