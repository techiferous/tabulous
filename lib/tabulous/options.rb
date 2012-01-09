module Tabulous

  class Css
    attr_accessor :scaffolding
    attr_accessor :background_color
    attr_accessor :text_color
    attr_accessor :active_tab_color
    attr_accessor :hover_tab_color
    attr_accessor :inactive_tab_color
    attr_accessor :inactive_text_color
    def initialize
      @scaffolding = false
      @background_color = '#ccc'
      @text_color = '#444'
      @active_tab_color = 'white'
      @hover_tab_color = '#ddd'
      @inactive_tab_color = '#aaa'
      @inactive_text_color = '#888'
    end
  end
  
  mattr_accessor :always_render_subtabs
  @@always_render_subtabs = false

  mattr_accessor :active_tab_clickable
  @@active_tab_clickable = false

  mattr_accessor :raise_error_if_no_tab_found
  @@raise_error_if_no_tab_found = true

  mattr_accessor :render_tabs_if_no_tab_found
  @@render_tabs_if_no_tab_found = false

  mattr_accessor :css
  @@css = Css.new

  mattr_accessor :html5
  @@html5 = false

end
