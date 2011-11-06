require File.expand_path("../integration_test_helper", File.dirname(__FILE__))

class SimpleTabsTest < ActionController::IntegrationTest
 
  test "viewing simple tabs" do
    visit '/'
    assert page.has_content?('This tests the most basic usage of tabulous.')
  end
 
  test "clicking galaxies tab" do
    visit '/'
    click_link 'Galaxies'
    assert page.has_content?('Listing galaxies')
    assert page.has_no_content?('Listing stars')
    assert page.has_no_content?('Listing planets')
  end
 
  test "clicking stars tab" do
    visit '/'
    click_link 'Stars'
    assert page.has_content?('Listing stars')
    assert page.has_no_content?('Listing galaxies')
    assert page.has_no_content?('Listing planets')
  end
 
  test "clicking planets tab" do
    visit '/'
    click_link 'Planets'
    assert page.has_content?('Listing planets')
    assert page.has_no_content?('Listing stars')
    assert page.has_no_content?('Listing galaxies')
  end
 
end
