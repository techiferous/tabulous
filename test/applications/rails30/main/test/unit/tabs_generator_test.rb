require File.expand_path('../test_helper', File.dirname(__FILE__))
require 'rails/generators'
require 'generators/tabs/tabs_generator'

class TabsGeneratorTest < Rails::Generators::TestCase
  tests TabsGenerator
  destination File.expand_path("../../tmp", File.dirname(__FILE__))
  setup :prepare_destination
 
  test "all files are properly created" do
    run_generator
    assert_file "app/tabs/tabulous.rb"
  end
end
