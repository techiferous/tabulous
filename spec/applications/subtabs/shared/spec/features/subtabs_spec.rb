require 'spec_helper'

describe 'home tab' do
  include TabHelpers
  before(:each) do
    visit '/'
  end
  it 'should work' do
    page.should have_content('Explanation')
  end
end

describe 'subtabs' do
  include TabHelpers

  it 'should display' do
    visit '/'
    click_link 'Galaxies'
    page.should have_content('Elliptical Galaxies')
    page.should have_content('Spiral Galaxies')
    page.should have_content('Lenticular Galaxies')
  end

  it 'should be selectable' do
    visit '/'
    click_link 'Galaxies'
    page.should have_content(/listing.+elliptical.+galaxies/i)
    click_link 'Spiral Galaxies'
    page.should have_content(/listing.+spiral.+galaxies/i)
    click_link 'Lenticular Galaxies'
    page.should have_content(/listing.+lenticular.+galaxies/i)
  end
end

describe 'tabs and subtabs' do
  include TabHelpers

  it 'can be hidden' do
    visit '/'
    visible_tabs.should_not include('Hidden')
    click_link 'Galaxies'
    visible_tabs.should include('Hidden')
    click_link 'Planets'
    visible_tabs.should_not include('Hidden')
    click_link 'Galaxies'
    click_link 'Hidden'
    visible_subtabs.should include('Always Visible')
    visible_subtabs.should_not include('Always Hidden')
  end

  it 'can be disabled' do
    visit '/'
    disabled_tabs.should include('Disabled')
    click_link 'Stars'
    enabled_tabs.should include('Disabled')
    visit '/'
    click_link 'Stars'
    click_link 'Disabled'
    enabled_subtabs.should include('Always Enabled')
    disabled_subtabs.should include('Always Disabled')
  end

  it 'can change the display text dynamically' do
    visit '/'
    click_link 'Stars'
    visible_tabs.should include('Stars!')
    visible_tabs.should_not include('Stars')
  end
end
