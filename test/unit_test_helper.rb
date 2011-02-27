$:.unshift(File.expand_path(File.dirname(__FILE__) + "/../lib"))
require 'rubygems'
require 'test/unit'
require 'redgreen'
require 'diffy'

module Test
  module Unit
    class TestCase
      # put shared unit test code here
    end
  end
end
