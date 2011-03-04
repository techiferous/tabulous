require 'tabulous'
require 'rails'

module Tabulous
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/tabulous.rake"
    end
    initializer 'tabulous.helper' do |app|  
      ActionView::Base.send :include, Tabulous::Helpers
    end
    config.to_prepare do
      filename = File.join(Rails.root.to_s, 'app/tabs/tabulous.rb')
      load filename if File.exists?(filename)
    end
  end
end
