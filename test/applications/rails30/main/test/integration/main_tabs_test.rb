require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class MainTabsTest < ActionController::IntegrationTest
 
  test "viewing main tabs" do
    visit '/'
    assert page.has_content?('Explanation')
  end
 
end
