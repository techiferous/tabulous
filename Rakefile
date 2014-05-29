# -*- encoding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks
require 'colored'
require 'rake'
require 'rdoc/task'
require 'rake/testtask'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run the unit specs"
  RSpec::Core::RakeTask.new(:units) do |t|
    t.pattern = "./spec/lib/**/*_spec.rb"
  end
end

task :test do
  puts
  puts "To run integration specs:"
  puts "  $ script/for_all_test_apps bundle exec rake"
  puts
  puts "To run integration specs in a Ruby 1.9 environment:"
  puts "  due to configuration issues, integration specs no longer run for the Ruby 1.9 environment"
  puts
  puts "To run integration specs in a Ruby 2.0 environment:"
  puts "  $ RUBY_COMPATIBILITY=2.0 script/for_all_test_apps bundle exec rake"
  puts
  puts "To run integration specs in a Ruby 2.1 environment:"
  puts "  $ RUBY_COMPATIBILITY=2.1 script/for_all_test_apps bundle exec rake"
  puts
  puts "To run unit specs:"
  puts "  $ bundle exec rake spec:units"
  puts
  puts "You may need to run this first before the integration specs will pass:"
  puts "  $ script/for_all_test_apps bundle install"
  puts
end

task :default => :test
