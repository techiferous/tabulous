# -*- encoding: utf-8 -*-

require 'rubygems'
require 'bundler'
Bundler::GemHelper.install_tasks
require 'colored'
require 'rake'
require 'rake/rdoctask'
require 'rake/testtask'

namespace :test do
  Dir['test/applications/*'].each do |filename|
    if File.directory?(filename)
      name = filename.split('/').last
      desc "run tests for the test application #{name}"
      Rake::TestTask.new(name) do |t|
        t.libs << 'lib'
        t.libs << 'test'
        t.pattern = "test/applications/#{name}/**/*_test.rb"
        t.verbose = false
      end
    end
  end
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
  Dir['test/applications/*'].each do |filename|
    if File.directory?(filename)
      name = filename.split('/').last
      puts "Running tests for test application \"#{name}\"".magenta
      puts %x{rake test:#{name}}
    end
  end
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
