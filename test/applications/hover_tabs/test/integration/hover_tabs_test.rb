require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class HoverTabsTest < ActionController::IntegrationTest
 
  test "viewing hover tabs" do
    visit '/'
    assert page.has_content?('Explanation')
  end
 
end
