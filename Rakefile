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
  puts "  $ script/for_all_test_apps rake"
  puts
  puts "To run unit specs:"
  puts "  $ rake spec:units"
  puts
  puts "You may need to run this first before the integration specs will pass:"
  puts "  $ script/for_all_test_apps bundle install"
  puts
end

task :default => :test

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Test'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
