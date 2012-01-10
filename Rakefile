# -*- encoding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks
require 'colored'
require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'

namespace :test do
  desc "run unit tests for tabulous"
  Rake::TestTask.new(:units) do |t|
    t.libs << 'lib'
    t.pattern = 'test/units/**/*_test.rb'
    t.verbose = true
  end
end

task :test do
  # we cannot load more than one Rails app at a time so we run the rake tasks
  # from the shell so that each has its own process
  Dir['test/applications/rails30/*'].each do |filename|
    if File.directory?(filename)
      name = filename.split('/').last
      puts "Running tests for the Rails 3.0 test application \"#{name}\"".magenta
      puts %x{cd #{filename} && bundle exec rake test}
    end
  end
  Dir['test/applications/rails31/*'].each do |filename|
    if File.directory?(filename)
      name = filename.split('/').last
      puts "Running tests for the Rails 3.1 test application \"#{name}\"".magenta
      puts %x{cd #{filename} && bundle exec rake test}
    end
  end
  puts "Running unit tests".magenta
  Rake::Task['test:units'].invoke
end

task :default => :test

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Test'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
