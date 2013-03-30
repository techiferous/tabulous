require File.expand_path('../../application_template_helper', __FILE__)

generate_test_application do

  #*****************************************************************************
  #  MODELS AND SCAFFOLDING

  generate(:scaffold, 'galaxy name:string')
  generate(:scaffold, 'planet name:string')
  generate(:scaffold, 'star name:string')

  #*****************************************************************************
  #  MORE CONTROLLERS AND VIEWS

  generate(:controller, 'home', 'index')
  replace_view 'home', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This tests the most basic usage of tabulous.
  CODE

  #*****************************************************************************
  #  MORE ROUTES

  route "root to: 'home#index'"

  #*****************************************************************************
  #  LAYOUT

  replace_application_layout <<-CODE.strip_heredoc
    <!DOCTYPE html>
    <html>
    <head>
      <title>SimpleTabs</title>
      <%= csrf_meta_tag %>
    </head>
    <body>

    <h1>Simple Tabs</h1>
    <%= tabs %>
    <%= yield %>

    </body>
    </html>
  CODE

end
