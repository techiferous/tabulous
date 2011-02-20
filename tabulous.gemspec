# -*- encoding: utf-8 -*-
require File.expand_path("../lib/tabulous/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tabulous"
  s.version     = Tabulous::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wyatt Greene"]
  s.email       = ["techiferous@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/tabulous"
  s.summary     = "Write a gem summary"
  s.description = "Write a gem description"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "tabulous"

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rails", ">= 3.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
