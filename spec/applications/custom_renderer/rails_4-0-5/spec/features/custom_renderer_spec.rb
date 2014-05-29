require 'spec_helper'

describe 'custom rendering' do
  before(:each) do
    visit '/'
  end
  it 'should work' do
    page.html.should include('<div class="tabs" class="from_custom_renderer">')
    page.html.should include('<li>stub</li><li>stub</li><li>stub</li><li>stub</li>')
  end
end
