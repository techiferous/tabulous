require 'tabulous'
require 'rails'

module Tabulous
  class Railtie < Rails::Railtie
    rake_tasks do
      load "tasks/tabulous.rake"
    end
  end
end
