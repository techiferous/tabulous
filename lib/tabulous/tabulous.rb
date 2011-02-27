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

  mattr_accessor :css
  @@css = Css.new

  mattr_accessor :html5
  @@html5 = false

  def self.setup
    yield self
  end
  
  def self.tabs=(ary)
    @@tabs = []
    last_tab = nil
    ary.each do |tab_args|
      begin
        tab = Tab.new(*tab_args)
      rescue ArgumentError
        # TODO: friendlier error message
        raise "Wrong number of columns in your tabulous initializer."
      end
      if tab.subtab?
        tab.add_parent(last_tab)
      else
        last_tab = tab
      end
      @@tabs << tab
    end
  end
  
  def self.actions=(ary)
    @@actions = {}
    ary.each do |controller, action, tab|
      @@actions[controller] ||= {}
      @@actions[controller][action] ||= []
      @@actions[controller][action] << tab
    end
  end
  
  def self.main_tabs
    @@tabs.select { |t| !t.subtab? }
  end
  
  def self.active_tab(view)
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    for tab in @@tabs
      if active?(controller, action, tab.name)
        if tab.subtab?
          return tab.parent
        else
          return tab
        end
      end
    end
    nil
  end

  def self.embed_styles
    return '' unless @@css.scaffolding
    %Q{
<style type="text/css">
body, #tabs, #tabs ul, #tabs ul li, #tabs ul li span, #tabs ul li span a,
#subtabs, #subtabs ul, #subtabs ul li, #subtabs ul li span, #subtabs ul li span a {
  margin: 0;
  padding: 0;
}

#tabs, #tabs a, #tabs a:visited, #tabs a:hover {
  color: #{@@css.text_color};
}

#tabs li.disabled, #tabs li.disabled a, #tabs li.disabled a:visited, #tabs li.disabled a:hover,
#subtabs li.disabled, #subtabs li.disabled a, #subtabs li.disabled a:visited, #subtabs li.disabled a:hover {
  color: #{@@css.inactive_text_color};
}

#tabs a {
  text-decoration: none;
}

#tabs ul {
  font-size: 24px;
  height: 59px;
  list-style-type: none;
  background-color: #{@@css.background_color};
  padding: 0 0 0 50px;
}

#tabs ul li {
  padding-top: 25px;
  padding-right: 5px;
  float: left;
}

#tabs ul li .tab {
  padding: 5px 15px 0px 15px;
  float: left;
	-webkit-border-top-left-radius: 8px;
	-khtml-border-radius-topleft: 8px;	
	-moz-border-radius-topleft: 8px;
	border-top-left-radius: 8px;
	-webkit-border-top-right-radius: 8px;
	-khtml-border-radius-topright: 8px;	
	-moz-border-radius-topright: 8px;
	border-top-right-radius: 8px;
}

#tabs ul li .tab {
  background-color: #{@@css.inactive_tab_color};
}

#tabs ul li.active .tab {
  background-color: #{@@css.active_tab_color};
  padding-bottom: 16px;
}

#tabs ul li a:hover {
  background-color: #{@@css.hover_tab_color};
}

#subtabs ul {
  margin-top: 15px;
}

#subtabs, #subtabs a, #subtabs a:visited {
  color: #{@@css.text_color};
}

#subtabs li.active {
  font-weight: bold;
}

#subtabs a {
  text-decoration: none;
}

#subtabs ul {
  font-size: 16px;
  height: 30px;
  list-style-type: none;
  padding: 0 0 0 50px;
}

#subtabs ul li {
  padding: 10px;
  float: left;
}

#subtabs ul li a:hover {
  text-decoration: underline;
}

</style>
    }
  end

  def self.render_tabs(view)
    html = ''
    html << embed_styles
    active_tab_name = active_tab(view).name
    html << (@@html5 ? '<nav id="tabs">' : '<div id="tabs">')
    html << '<ul>'
    for tab in main_tabs
      next if !tab.visible?(view)
      html << render_tab(:text => tab.text(view),
                         :path => tab.path(view),
                         :active => (tab.name == active_tab_name),
                         :enabled => tab.enabled?(view))
    end
    html << '</ul>'
    html << (@@html5 ? '</nav>' : '</div>')
    view.raw(html)
  end
  
  def self.render_subtabs(view)
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    tab = active_tab(view)
    html = ''
    html << (@@html5 ? '<nav id="subtabs">' : '<div id="subtabs">')
    html << '<ul>'
    for subtab in tab.subtabs
      next if !subtab.visible?(view)
      html << render_tab(:text => subtab.text(view),
                         :path => subtab.path(view),
                         :active => active?(controller, action, subtab.name),
                         :enabled => subtab.enabled?(view))
    end
    html << '</ul>'
    html << (@@html5 ? '</nav>' : '</div>')
    view.raw(html)
  end

  def self.render_tab(options)
    html = ''
    klass = (options[:active] ? 'active' : 'inactive')
    klass << (options[:enabled] ? ' enabled' : ' disabled')
    html << %Q{<li class="#{klass}">}
    if options[:active] || options[:enabled] == false
      html << %Q{<span class="tab">#{options[:text]}</span>}
    else
      html << %Q{<a href="#{options[:path]}" class="tab">#{options[:text]}</a>}
    end
    html << '</li>'
    html
  end

  def self.active?(controller, action, tab_name)
    if @@actions[controller].nil?
      # TODO: better error message or perhaps don't render tabs
      raise "No tabs are defined for controller '#{controller}'"
    end
    if @@actions[controller][action].nil? && !@@actions[controller][:all_actions]
      # TODO: better error message or perhaps don't render tabs
      raise "No tab is defined for controller '#{controller}' action '#{action}'"
    end
    (@@actions[controller][action] && @@actions[controller][action].include?(tab_name)) ||
     (@@actions[controller][:all_actions] && @@actions[controller][:all_actions].include?(tab_name))
  end
  
  class Tab
    
    attr_reader :name, :parent
    attr_accessor :subtabs
    
    def initialize(name, text, path, visible, enabled)
      @name = name
      name = name.to_s
      if name.ends_with? '_tab'
        @kind = :tab
      elsif name.ends_with? '_subtab'
        @kind = :subtab
      else
        raise "tab name error"
      end
      @text = text
      @path = path
      @visible = visible
      @enabled = enabled
      @subtabs = []
    end
    
    def add_parent(tab)
      @parent = tab
      @parent.subtabs = @parent.subtabs + [self]
    end
    
    def subtab?
      @kind == :subtab
    end
    
    def text(view)
      if @text.is_a? Proc
        view.instance_eval(&@text)
      else
        @text
      end
    end
    
    def path(view)
      if @path.is_a? Proc
        view.instance_eval(&@path)
      else
        @path
      end
    end
    
    def visible?(view)
      if @visible.is_a? Proc
        !!view.instance_eval(&@visible)
      else
        !!@visible
      end
    end
    
    def enabled?(view)
      if @enabled.is_a? Proc
        !!view.instance_eval(&@enabled)
      else
        !!@enabled
      end
    end
    
  end

  module Helpers
    
    def tabs
      Tabulous.render_tabs(self)
    end

    def subtabs
      Tabulous.render_subtabs(self)
    end

  end

end
