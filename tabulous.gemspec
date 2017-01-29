# -*- encoding: utf-8 -*-
require File.expand_path("../lib/tabulous/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tabulous"
  s.version     = Tabulous::VERSION
  s.licenses    = ['MIT']
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wyatt Greene"]
  s.email       = ["techiferous@gmail.com"]
  s.homepage    = "https://github.com/techiferous/tabulous"
  s.summary     = "Easy tabbed navigation for Rails."
  s.description = "Tabulous provides an easy way to add tabs to your Rails application."

  s.required_rubygems_version = ">= 1.3.7"
  s.rubyforge_project         = "tabulous"

  s.add_dependency "colored", "~> 1.2.0"
  s.add_dependency "rails", ">= 3.0", "< 6.0.0"
  s.add_development_dependency "bundler", "~> 1.3"
  s.add_development_dependency "capybara", "~> 2.10.1"
  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_development_dependency "rspec", "~> 3.5.0"
  s.add_development_dependency "launchy"
  s.add_development_dependency "diffy"
  s.add_development_dependency 'sqlite3', '>= 1.3.9'

  s.files        = `git ls-files`.split("\n")
  s.require_path = 'lib'
end
