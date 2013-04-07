require File.expand_path('../../application_template_helper', __FILE__)

generate_test_application do

  #*****************************************************************************
  #  MODELS AND SCAFFOLDING

  generate(:scaffold, 'galaxy name:string --old-style-hash')
  generate(:scaffold, 'planet name:string --old-style-hash')
  generate(:scaffold, 'star name:string --old-style-hash')

  #*****************************************************************************
  #  MORE CONTROLLERS AND VIEWS

  generate(:controller, 'home index --old-style-hash')
  replace_view 'home', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This tests using a custom renderer for the tabs.
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
      <title>CustomRenderer</title>
      <%= csrf_meta_tag %>
    </head>
    <body>

    <h1>Custom Renderer</h1>
    <%= tabs %>
    <%= yield %>

    </body>
    </html>
  CODE

end
