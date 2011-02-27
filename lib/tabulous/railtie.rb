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
    initializer 'tabulous.reload' do |app|
      ActiveSupport.on_load(:action_controller) do
        if Rails.env.development?
          before_filter do
            # reload tabulous initializer on every request if in development mode
            load File.join(Rails.root.to_s, 'config/initializers/tabulous.rb')
          end
        end
      end
    end
  end
end
