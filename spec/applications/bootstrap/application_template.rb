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
    This tests tabulous integrating with Twitter Bootstrap.
  CODE
  generate(:controller, 'no_tabs index --old-style-hash')
  replace_view 'no_tabs', 'index', <<-CODE.strip_heredoc
    <h1>Explanation</h1>
    This tests what happens when you visit a controller action that is not associated
    with any tab.
  CODE
  generate(:controller, 'subtabs one two three --old-style-hash')
  replace_view 'subtabs', 'one', '<p>Subtab #1</p>'
  replace_view 'subtabs', 'two', '<p>Subtab #2</p>'
  replace_view 'subtabs', 'three', '<p>Subtab #3</p>'

  #*****************************************************************************
  #  MORE ROUTES

  route "root :to => 'home#index'"
  route "get 'notabs' => 'no_tabs#index'"

  #*****************************************************************************
  #  LAYOUT

  replace_application_layout <<-CODE.strip_heredoc
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <title>Bootstrap</title>
      <%= csrf_meta_tag %>
      <%= stylesheet_link_tag 'application' %>
      <%= javascript_include_tag 'application' %>
    </head>
    <body>

      <div class="navbar navbar-inverse navbar-fixed-top">
        <div class="navbar-inner">
          <div class="container">
            <a class="brand" href="#">Tabulous Bootstrap Test App</a>
            <%= tabs %>
          </div>
        </div>
      </div>

      <div id="main_content" class="container">
        <%= yield %>
      </div>

    </body>
    </html>
  CODE

  #*****************************************************************************
  #  CSS CLEANUP

  remove_file 'app/assets/stylesheets/application.css'
  remove_file 'app/assets/stylesheets/scaffolds.css.scss'

end
