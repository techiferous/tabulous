#**************************************************************************************#
#   Refer to spec/applications/README for a full understanding of test applications.   #
#**************************************************************************************#

# This method describes the Gemfile that will be used by all test applications.
def add_gems
  remove_file 'Gemfile'
  add_file 'Gemfile', "source 'https://rubygems.org'"
  gem 'tabulous', :path => "../../../.."
  gem 'sqlite3', '>= 1.3.7'
  if rails_version? '3.0'
    gem 'rails', '~> 3.0.0'
  elsif rails_version? '3.1'
    gem 'rails', '~> 3.1.0'
    gem_group :assets do
      gem 'sass-rails',   '~> 3.1.4'
      gem 'coffee-rails', '~> 3.1.1'
      gem 'uglifier', '>= 1.0.3'
    end
    gem 'jquery-rails'
  end
  gem_group :test do
    gem 'capybara', "~> 2.0.2"
    gem 'launchy'
    gem 'redgreen' unless RUBY_VERSION >= "1.9"
    if rails_version? '3.1'
      gem 'turn', :require => false
      gem 'minitest'
    end
  end
  gem_group :test, :development do
    gem "rspec-rails"
  end
end
