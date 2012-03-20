# -*- encoding: utf-8 -*-
require File.expand_path("../lib/tabulous/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "tabulous"
  s.version     = Tabulous::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Wyatt Greene"]
  s.email       = ["techiferous@gmail.com"]
  s.homepage    = "https://github.com/techiferous/tabulous"
  s.summary     = "Easy tabbed navigation for Rails."
  s.description = "Tabulous provides an easy way to add tabs to your Rails application."

  s.required_rubygems_version = ">= 1.3.7"
  s.rubyforge_project         = "tabulous"

  s.add_dependency "colored", "~> 1.2.0"
  s.add_dependency "rails", "~> 3.0"
  s.add_development_dependency "bundler", "~> 1.1.1"
  s.add_development_dependency "capybara", "~> 1.1.2"
  s.add_development_dependency "rake", "=0.8.7"
  if RUBY_VERSION < "1.9"
    s.add_development_dependency "redgreen"
  end
  s.add_development_dependency "launchy"
  s.add_development_dependency "diffy"
  s.add_development_dependency 'sqlite3-ruby', '~> 1.3.3'
  s.add_development_dependency 'sqlite3', '=1.3.4'

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
end
