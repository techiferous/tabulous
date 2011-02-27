require File.expand_path("../integration_test_helper", File.dirname(__FILE__))
 
class SubtabsTest < ActionController::IntegrationTest
 
  test "viewing subtabs application" do
    visit '/'
    assert page.has_content?('Explanation')
  end
 
  test "displaying subtabs" do
    visit '/'
    click_link 'Galaxies'
    assert page.has_content?('Elliptical Galaxies')
    assert page.has_content?('Spiral Galaxies')
    assert page.has_content?('Lenticular Galaxies')
  end
 
  test "selecting a subtab" do
    visit '/'
    click_link 'Galaxies'
    assert page.has_content?('Listing elliptical_galaxies')
    click_link 'Spiral Galaxies'
    assert page.has_content?('Listing spiral_galaxies')
    click_link 'Lenticular Galaxies'
    assert page.has_content?('Listing lenticular_galaxies')
  end
 
  test "tab visibility" do
    visit '/'
    assert_tab_not_present 'Hidden'
    click_link 'Galaxies'
    assert_tab_present 'Hidden'
    click_link 'Planets'
    assert_tab_not_present 'Hidden'
  end
 
  test "subtab visibility" do
    click_link 'Galaxies'
    click_link 'Hidden'
    assert_subtab_present 'Always Visible'
    assert_subtab_not_present 'Always Hidden'
  end
 
  test "changing tab text" do
    click_link 'Stars'
    assert_tab_present 'Stars!'
    assert_tab_not_present 'Stars'
  end
 
end
