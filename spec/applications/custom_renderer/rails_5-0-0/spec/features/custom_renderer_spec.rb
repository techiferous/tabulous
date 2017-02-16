require 'spec_helper'

describe 'custom rendering' do
  before(:each) do
    visit '/'
  end
  it 'should work' do
    expect(page.html).to include('<div class="tabs" class="from_custom_renderer">')
    expect(page.html).to include('<li>stub</li><li>stub</li><li>stub</li><li>stub</li>')
  end
end
