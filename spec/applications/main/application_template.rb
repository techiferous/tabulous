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
    This tests tabulous in all sorts of configurations.
  CODE
  generate(:controller, 'no_tabs', 'index')
  replace_view 'no_tabs', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This tests what happens when you visit a controller action that is not associated
    with any tab.
  CODE
  generate(:controller, 'subtabs', 'one', 'two', 'three')
  replace_view 'subtabs', 'one', '<p>Subtab #1</p>'
  replace_view 'subtabs', 'two', '<p>Subtab #2</p>'
  replace_view 'subtabs', 'three', '<p>Subtab #3</p>'

  #*****************************************************************************
  #  MORE ROUTES

  route "root to: 'home#index'"
  route "match 'notabs' => 'no_tabs#index'"

  #*****************************************************************************
  #  LAYOUT

  replace_application_layout <<-CODE.strip_heredoc
    <!DOCTYPE html>
    <html>
    <head>
      <title>Main</title>
      <%= stylesheet_link_tag :all %>
      <%= javascript_include_tag :defaults %>
      <%= csrf_meta_tag %>
    </head>
    <body>

    <%= tabs %>
    <%= subtabs %>
    <%= yield %>

    </body>
    </html>
  CODE

end
