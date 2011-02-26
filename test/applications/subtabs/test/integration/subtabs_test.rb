require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class SubtabsTest < ActionController::IntegrationTest
 
  test "viewing subtabs" do
    visit '/'
    assert page.has_content?('Explanation')
  end
 
end
