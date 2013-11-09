require_relative '../../spec_helper'

describe Tabulous::BootstrapNavbarRenderer do
  include Tabulous::TestData

  before(:each) do
    create_sample_tabset
    @renderer = Tabulous::BootstrapNavbarRenderer.new(@tabset, @view)
  end

  it "should return Bootstrap HTML for tabs with a navbar-nav class" do
    tabs_html = @renderer.tabs_html
    tabs_html.should be_a(String)
    expect(tabs_html).to match(/<ul class="nav navbar-nav">/)
    expect(tabs_html).to_not match(/<ul class="nav nav-pills">/)
    expect(tabs_html).to_not match(/<ul class="nav nav-tabs">/)
    expect(tabs_html).to_not match(/<div class="tabs">/)
  end

  it "should not show invisible tabs" do
    expect(@renderer.tabs_html).to_not match(/cookies/)
  end

  it "should have the correct HTML for disabled tabs" do
    expect(@renderer.tabs_html).to match(/<li class="disabled"><a>cupcakes<\/a><\/li>/)
  end

  it "should return the expected HTML" do
    tabs_html = @renderer.tabs_html
    expected_html = <<-HTML.strip_heredoc
      <ul class="nav navbar-nav">
        <li><a href="/cakes">cakes</a></li><li class="disabled"><a>cupcakes</a></li><li class="active dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#">breads<b class="caret"></b></a><ul class="dropdown-menu"><li><a href="/breads/spoonbread">spoonbread</a></li><li><a href="/breads/banana-bread">banana bread</a></li></ul></li>
      </ul>
    HTML
    tabs_html.should == expected_html
  end

end
