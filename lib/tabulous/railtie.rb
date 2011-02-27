require 'tabulous'
require 'rails'

module Tabulous
  class Railtie < Rails::Railtie
    initializer 'tabulous.helper' do |app|  
      ActionView::Base.send :include, Tabulous::Helpers
    end  
    rake_tasks do
      load "tasks/tabulous.rake"
    end
  end
end
