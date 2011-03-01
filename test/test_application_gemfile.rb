# This DRYs up the Gemfiles of our test applications.

def shared_test_application_gems(bundler)
  bundler.instance_eval do
    gem 'rails', '>= 3.0.0'
    gem 'sqlite3-ruby', :require => 'sqlite3'
    gem 'tabulous', :path => "../../.."
    group :test do
      gem 'capybara'
      gem 'launchy'
      gem 'redgreen' unless RUBY_VERSION >= "1.9"
    end
  end
end
