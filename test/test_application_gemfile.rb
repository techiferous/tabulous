# This DRYs up the Gemfiles of our test applications.

def shared_test_application_gems(bundler)
  bundler.instance_eval do
    gem 'rails', '>= 3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'tabulous', :path => "../../.."
    gem 'capybara'
    gem 'redgreen'
  end
end
