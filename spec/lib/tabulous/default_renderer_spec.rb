require_relative '../../spec_helper'

describe Tabulous::DefaultRenderer do
  include Tabulous::TestData

  before(:each) do
    create_sample_tabset
    @renderer = Tabulous::DefaultRenderer.new(@tabset, @view)
  end

  it "should return HTML for tabs" do
    tabs_html = @renderer.tabs_html
    tabs_html.should be_a(String)
    expect(tabs_html).to match(/<div class="tabs">/)
    expect(tabs_html).to_not match(/<div class="subtabs">/)
  end

  it "should return HTML for subtabs" do
    subtabs_html = @renderer.subtabs_html
    subtabs_html.should be_a(String)
    expect(subtabs_html).to match(/<div class="subtabs">/)
    expect(subtabs_html).to_not match(/<div class="tabs">/)
  end

  it "should not show invisible tabs" do
    expect(@renderer.tabs_html).to_not match(/cookies/)
  end

  it "should have the correct HTML for disabled tabs" do
    expect(@renderer.tabs_html).to match(/<li class="disabled"><span class="tab">cupcakes<\/span><\/li>/)
  end

  it "should return the expected HTML for tabs" do
    tabs_html = @renderer.tabs_html
    expected_html = <<-HTML.strip_heredoc
      <div class="tabs">
        <ul>
          <li><a href="/cakes" class="tab">cakes</a></li><li class="disabled"><span class="tab">cupcakes</span></li><li class="active"><a href="/breads" class="tab">breads</a></li>
        </ul>
      </div>
    HTML
    tabs_html.should == expected_html
  end

  it "should return the expected HTML for subtabs" do
    subtabs_html = @renderer.subtabs_html
    expected_html = <<-HTML.strip_heredoc
      <div class="subtabs">
        <ul>
          <li class="active"><a href="/breads/spoonbread" class="tab">spoonbread</a></li><li><a href="/breads/banana-bread" class="tab">banana bread</a></li>
        </ul>
      </div>
    HTML
    subtabs_html.should == expected_html
  end
end
