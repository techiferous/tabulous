require 'spec_helper'

describe 'multiple tabsets' do
  it 'should work' do
    visit '/'
    expect(page).to have_content('Explanation')
    click_link 'tab set one'
    expect(page).to have_content('Elliptical Galaxies')
    expect(page).to have_content('Spiral Galaxies')
    expect(page).to have_content('Lenticular Galaxies')
    expect(page).not_to have_content('Exoplanets')
    expect(page).not_to have_content('Rogue Planets')
    visit '/'
    click_link 'tab set two'
    expect(page).to have_content('Exoplanets')
    expect(page).to have_content('Rogue Planets')
    expect(page).not_to have_content('Elliptical Galaxies')
    expect(page).not_to have_content('Spiral Galaxies')
    expect(page).not_to have_content('Lenticular Galaxies')
  end
end
