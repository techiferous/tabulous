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

<% index_routes = Rails.application.routes.routes.select{|r| r.requirements[:action] == 'index'}
   tab_data = index_routes.map do |route|
     name = route.requirements[:controller].gsub('/', '_')
     { :text => name.titleize,
       :name => name,
       :path_helper => route.name + '_path' }
   end
-%>
<%= s = []
    s <<  '  config.tabs = ['
    s <<  '    #-------------------------------------------------------------------------------------------------#'
    s <<  '    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #'
    s <<  '    #-------------------------------------------------------------------------------------------------#'
    for tab in tab_data
      s << "[    :#{tab[:name]}_tab  ,  '#{tab[:text]}'    ,  lambda { #{tab[:path_helper]} }  ,  true  ,  true  ],"
    end
    s <<  '    #-------------------------------------------------------------------------------------------------#'
    s <<  '    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #'
    s <<  '    #-------------------------------------------------------------------------------------------------#'
    s <<  '  ]'
    Tabulous::Formatter.format(s).join("\n") %>

<%= s = []
    s <<  '  config.actions = ['
    s <<  '    #-------------------------------------------------------------#'
    s <<  '    #    CONTROLLER    |    ACTION          |    TAB              #'
    s <<  '    #-------------------------------------------------------------#'
    for tab in tab_data
      s << "[    :#{tab[:name]}  ,  :all_actions  ,  :#{tab[:name]}_tab  ],"
    end
    s <<  '    #-------------------------------------------------------------#'
    s <<  '    #    CONTROLLER    |    ACTION          |    TAB              #'
    s <<  '    #-------------------------------------------------------------#'
    s <<  '  ]'
    Tabulous::Formatter.format(s).join("\n") %>
  
  # config.active_tab_clickable = true
  # config.always_render_subtabs = true
  # config.raise_error_if_no_tab_found = false
  # config.html5 = true

  config.css.scaffolding = true
  # config.css.background_color = '#ccc'
  # config.css.text_color = '#444'
  # config.css.active_tab_color = 'white'
  # config.css.hover_tab_color = '#ddd'
  # config.css.inactive_tab_color = '#aaa'
  # config.css.inactive_text_color = '#888'


end
