require 'colored'
class TabsGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  def create_tabs_initializer_file
    template "tabulous.rb", "config/initializers/tabulous.rb" 
    puts
    puts ("Tabulous made some guesses about how you want your tabs configured but " +
          "probably got some things wrong.  So you need to edit " +
          "config/initializers/tabulous.rb to your liking.").magenta
    puts
    puts "Don't forget to put <%= tabs %> and <%= subtabs %> in your layout(s).".magenta
  end
end
