require 'capybara/rails'

module ActionController
  class IntegrationTest
    include Capybara
  end
end
