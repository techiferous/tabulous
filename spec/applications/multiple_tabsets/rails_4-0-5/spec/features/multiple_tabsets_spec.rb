require 'spec_helper'

describe 'multiple tabsets' do
  it 'should work' do
    visit '/'
    page.should have_content('Explanation')
    click_link 'tab set one'
    page.should have_content('Elliptical Galaxies')
    page.should have_content('Spiral Galaxies')
    page.should have_content('Lenticular Galaxies')
    page.should_not have_content('Exoplanets')
    page.should_not have_content('Rogue Planets')
    visit '/'
    click_link 'tab set two'
    page.should have_content('Exoplanets')
    page.should have_content('Rogue Planets')
    page.should_not have_content('Elliptical Galaxies')
    page.should_not have_content('Spiral Galaxies')
    page.should_not have_content('Lenticular Galaxies')
  end
end
