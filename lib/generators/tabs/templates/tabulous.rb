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

  config.tabs = [
    #-------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------#
<% for c in controllers -%>
    [    :<%= c %>_tab  ,  '<%= c.titleize %>'  ,  '/<%= c %>'  ,  true  ,  true  ],
<% end -%>
    #-------------------------------------------------------------------------------------------------#
    #    TAB NAME         |    DISPLAY TEXT     |    PATH           |    VISIBLE?    |    ENABLED?    #
    #-------------------------------------------------------------------------------------------------#
  ]

  config.actions = [
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
<% for c in controllers -%>
    [    :<%= c %>  ,  :all_actions  ,  :<%= c %>_tab  ],
<% end -%>
    #-------------------------------------------------------------#
    #    CONTROLLER    |    ACTION          |    TAB              #
    #-------------------------------------------------------------#
  ]
  
  config.css.scaffolding = true

end
