require 'spec_helper'

describe 'front page' do
  it 'should have an explanation' do
    visit '/'
    expect(page).to have_text('Explanation')
  end
end
