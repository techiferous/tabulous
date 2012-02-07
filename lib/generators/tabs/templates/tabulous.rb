# Tabulous gives you an easy way to set up tabs for your Rails application.
#
#   1. Configure this file.
#   2. Add <%%= tabs %> and <%%= subtabs %> in your layout(s) wherever you want
#      your tabs to appear.
#   3. Add styles for these tabs in your stylesheets.
#   4. Profit!

<% controllers = []
   Dir[File.join(Rails.root.to_s, 'app/controllers/*.rb')].each do |filename|
     filename = filename.split('/').last
     if filename =~ /(\w+)_controller.rb/
       controller_name = $1.downcase
       if controller_name != 'application'
         controllers << controller_name
       end
     end
   end
-%>
Tabulous.setup do |config|

  #---------------------------
  #   HOW TO USE THE TABLES
  #---------------------------
  #
  # The following tables are just an array of arrays.  As such, you can put
  # any Ruby code into a cell.  For example, you could put "/foo/bar" in
  # a path cell or you could put "/foo" + "/bar".  You can even wrap up code
  # in a lambda to be executed later.  These will be executed in the context
  # of a Rails view meaning they will have access to view helpers.
  #
  # However, there is something special about the format of these tables.
  # Because it would be a pain for you to manually prettify the tables each
  # time you edit them, there is a special rake task that does this for
  # you: rake tabs:format.  However, for this prettifier to work properly
  # you have to follow some special rules:
  #
  #   * No comments are allowed between rows.
  #   * Comments are allowed to the right of rows, except for header rows.
  #   * The start of a table is signified by a [ all by itself on a line.
  #   * The end of a table is signified by a ] all by itself on a line.
  #   * And most importantly: commas that separate cells should be surrounded
  #     by spaces and commas that are within cells should not.  This gives the
  #     formatter an easy way to distinguish between cells without having
  #     to actually parse the Ruby.

  #----------
  #   TABS
  #----------
  #
  # This is where you define your tabs and subtabs.  The order that the tabs
  # appear in this list is the order they will appear in your views.  Any
  # subtabs defined will have the previous tab as their parent.
  #
  # TAB NAME
  #   must end in _tab or _subtab
  # DISPLAY TEXT
  #   the text the user sees on the tab
  # PATH
  #   the URL that gets sent to the server when the tab is clicked
  # VISIBLE
  #   whether to display the tab
  # ENABLED
  #   whether the tab is disabled (unclickable)

<% index_routes = Rails.application.routes.routes.select{|r| r.requirements[:action] == 'index'}
   tab_data = index_routes.map do |route|
     name = route.requirements[:controller].gsub('/', '_')
     if route.name.nil?
       path = "url_for(:controller => '#{route.requirements[:controller]}', :action => 'index')"
     else
       path = route.name + '_path'
     end
     { :text => name.titleize,
       :name => name,
       :path_helper => path }
   end
-%>
<%= s = []
    s <<  '  config.tabs do'
    s <<  '    ['
    s <<  '      #-------------------------------------------------------------------------------------------------#'
    s <<  '      #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #'
    s <<  '      #-------------------------------------------------------------------------------------------------#'
    for tab in tab_data
      s << "[    :#{tab[:name]}_tab  ,  '#{tab[:text]}'    ,  #{tab[:path_helper]}  ,  true  ,  true  ],"
    end
    s <<  '      #-------------------------------------------------------------------------------------------------#'
    s <<  '      #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #'
    s <<  '      #-------------------------------------------------------------------------------------------------#'
    s <<  '    ]'
    s <<  '  end'
    Tabulous::Formatter.format(s).join("\n") %>

  #-------------
  #   ACTIONS
  #-------------
  #
  # This is where you hook up actions with tabs.  That way tabulous knows
  # which tab and subtab to mark active when an action is rendered.
  #
  # CONTROLLER
  #   the name of the controller
  # ACTION
  #   the name of the action, or :all_actions
  # TAB
  #   the name of the tab or subtab that is active when this action is rendered

<%= s = []
    s <<  '  config.actions do'
    s <<  '    ['
    s <<  '      #-------------------------------------------------------------#'
    s <<  '      #    CONTROLLER    |    ACTION          |    TAB              #'
    s <<  '      #-------------------------------------------------------------#'
    for tab in tab_data
      s << "[    :#{tab[:name]}  ,  :all_actions  ,  :#{tab[:name]}_tab  ],"
    end
    s <<  '      #-------------------------------------------------------------#'
    s <<  '      #    CONTROLLER    |    ACTION          |    TAB              #'
    s <<  '      #-------------------------------------------------------------#'
    s <<  '    ]'
    s <<  '  end'
    Tabulous::Formatter.format(s).join("\n") %>

  #---------------------
  #   GENERAL OPTIONS
  #---------------------

  # By default, you cannot click on the active tab.
  config.active_tab_clickable = false

  # By default, the subtabs HTML element is not rendered if it is empty.
  config.always_render_subtabs = false

  # Tabulous expects every controller action to be associated with a tab.
  # When an action does not have an associated tab (or subtab), you can
  # instruct tabulous how to behave:
  config.when_action_has_no_tab = :raise_error      # the default behavior
  # config.when_action_has_no_tab = :do_not_render  # no tab navigation HTML will be generated
  # config.when_action_has_no_tab = :render         # the tab navigation HTML will be generated,
                                                    # but no tab or subtab will be active

  #--------------------
  #   MARKUP OPTIONS
  #--------------------

  # By default, div elements are used in the tab markup.  When html5 is
  # true, nav elements are used instead.
  config.html5 = false

  # This gives you control over what class the <ul> element that wraps the tabs
  # will have.  Good for interfacing with third-party code like Twitter
  # Bootstrap.
  # config.tabs_ul_class = "nav nav-pills"

  # Set this to true to have subtabs rendered in markup that Twitter Bootstrap
  # understands.  If this is set to true, you don't need to call subtabs in
  # your layout, just tabs.
  # config.bootstrap_style_subtabs = true


  #-------------------
  #   STYLE OPTIONS
  #-------------------
  #
  # The markup that is generated has the following properties:
  #
  #   Tabs and subtabs that are selected have the class "active".
  #   Tabs and subtabs that are not selected have the class "inactive".
  #   Tabs that are disabled have the class "disabled"; otherwise, "enabled".
  #   Tabs that are not visible do not appear in the markup at all.
  #
  # These classes are provided to make it easier for you to create your
  # own CSS (and JavaScript) for the tabs.

  # Some styles will be generated for you to get you off to a good start.
  # Scaffolded styles are not meant to be used in production as they
  # generate invalid HTML markup.  They are merely meant to give you a
  # head start or an easy way to prototype quickly.  Set this to false if
  # you are using Twitter Bootstrap.
  # 
  config.css.scaffolding = true

  # You can tweak the colors of the generated CSS.
  #
  # config.css.background_color = '#ccc'
  # config.css.text_color = '#444'
  # config.css.active_tab_color = 'white'
  # config.css.hover_tab_color = '#ddd'
  # config.css.inactive_tab_color = '#aaa'
  # config.css.inactive_text_color = '#888'

end
