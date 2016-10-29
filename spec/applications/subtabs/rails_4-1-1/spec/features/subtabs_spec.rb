require 'spec_helper'

describe 'home tab' do
  include TabHelpers
  before(:each) do
    visit '/'
  end
  it 'should work' do
    expect(page).to have_content('Explanation')
  end
end

describe 'subtabs' do
  include TabHelpers

  it 'should display' do
    visit '/'
    click_link 'Galaxies'
    expect(page).to have_content('Elliptical Galaxies')
    expect(page).to have_content('Spiral Galaxies')
    expect(page).to have_content('Lenticular Galaxies')
  end

  it 'should be selectable' do
    visit '/'
    click_link 'Galaxies'
    expect(page).to have_content('Listing galaxies_elliptical_galaxies')
    click_link 'Spiral Galaxies'
    expect(page).to have_content('Listing galaxies_spiral_galaxies')
    click_link 'Lenticular Galaxies'
    expect(page).to have_content('Listing galaxies_lenticular_galaxies')
  end
end

describe 'tabs and subtabs' do
  include TabHelpers

  it 'can be hidden' do
    visit '/'
    expect(visible_tabs).not_to include('Hidden')
    click_link 'Galaxies'
    expect(visible_tabs).to include('Hidden')
    click_link 'Planets'
    expect(visible_tabs).not_to include('Hidden')
    click_link 'Galaxies'
    click_link 'Hidden'
    expect(visible_subtabs).to include('Always Visible')
    expect(visible_subtabs).not_to include('Always Hidden')
  end

  it 'can be disabled' do
    visit '/'
    expect(disabled_tabs).to include('Disabled')
    click_link 'Stars'
    expect(enabled_tabs).to include('Disabled')
    visit '/'
    click_link 'Stars'
    click_link 'Disabled'
    expect(enabled_subtabs).to include('Always Enabled')
    expect(disabled_subtabs).to include('Always Disabled')
  end

  it 'can change the display text dynamically' do
    visit '/'
    click_link 'Stars'
    expect(visible_tabs).to include('Stars!')
    expect(visible_tabs).not_to include('Stars')
  end
end
