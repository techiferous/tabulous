# This DRYs up the Gemfiles of our test applications.

def shared_test_application_gems(bundler, rails_version)
  bundler.instance_eval do
    gem 'tabulous', :path => "../../../.."
    gem 'sqlite3', '>= 1.3.7'
    if rails_version == '3.0'
      gem 'rails', '~> 3.0.0'
    elsif rails_version == '3.1'
      gem 'rails', '~> 3.1.0'
      group :assets do
        gem 'sass-rails',   '~> 3.1.4'
        gem 'coffee-rails', '~> 3.1.1'
        gem 'uglifier', '>= 1.0.3'
      end
      gem 'jquery-rails'
    else
      raise "Unknown rails version '#{rails_version}'."
    end
    group :test do
      gem 'capybara', "~> 1.1.2"
      gem 'launchy'
      gem 'redgreen' unless RUBY_VERSION >= "1.9"
      if rails_version == '3.1'
        gem 'turn', :require => false
        gem 'minitest'
      end
    end
  end
end
