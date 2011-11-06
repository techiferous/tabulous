# This DRYs up the Gemfiles of our test applications.

def shared_test_application_gems(bundler, rails_version)
  bundler.instance_eval do
    if rails_version == '3.0'
      gem 'rails', '~>3.0.0'
    elsif rails_version == '3.1'
      gem 'rails', '~>3.1.0'
      group :assets do
        gem 'sass-rails',   '~> 3.1.4'
        gem 'coffee-rails', '~> 3.1.1'
        gem 'uglifier', '>= 1.0.3'
      end
      gem 'jquery-rails'
      gem 'sqlite3', '1.3.4'
    else
      raise "Unknown rails version '#{rails_version}'."
    end
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'tabulous', :path => "../../../.."
    group :test do
      gem 'capybara'
      gem 'launchy'
      gem 'redgreen' unless RUBY_VERSION >= "1.9"
      if rails_version == '3.1'
        gem 'turn', :require => false
        gem 'minitest'
      end
    end
  end
end
