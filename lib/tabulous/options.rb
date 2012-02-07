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

  mattr_accessor :when_action_has_no_tab
  @@when_action_has_no_tab = :raise_error

  mattr_accessor :css
  @@css = Css.new

  mattr_accessor :html5
  @@html5 = false

  mattr_accessor :tabs_ul_class
  @@tabs_ul_class = nil

  mattr_accessor :bootstrap_style_subtabs
  @@bootstrap_style_subtabs = false

  def self.raise_error_if_no_tab_found=(value)
    msg = "DEPRECATION WARNING: Tabulous's config.raise_error_if_no_tab_found "
    msg << "has been replaced by config.when_action_has_no_tab. "
    msg << "Acceptable values are :raise_error, :do_not_render, or :render."
    Rails.logger.warn msg
    if value
      self.when_action_has_no_tab = :raise_error
    else
      self.when_action_has_no_tab = :do_not_render
    end
  end

end
