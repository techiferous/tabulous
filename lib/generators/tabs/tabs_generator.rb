class TabsGenerator < Rails::Generators::Base
  source_root File.expand_path("../templates", __FILE__)
  def create_tabs_initializer_file
    template "tabulous.rb", "config/initializers/tabulous.rb" 
  end
end
