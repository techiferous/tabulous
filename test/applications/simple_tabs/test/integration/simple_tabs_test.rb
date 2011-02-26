require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class SimpleTabsTest < ActionController::IntegrationTest
 
  test "viewing simple tabs" do
    visit '/'
    assert page.has_content?('Explanation')
  end
 
end
