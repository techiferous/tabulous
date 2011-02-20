module Tabulous

  mattr_accessor :always_render_subtabs
  @@always_render_subtabs = false
  
  mattr_accessor :selected_tab_linkable
  @@selected_tab_linkable = false
  
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
  
  def self.selected_tab(view)
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    for tab in @@tabs
      if selected?(controller, action, tab.name)
        if tab.subtab?
          return tab.parent
        else
          return tab
        end
      end
    end
    nil
  end
  
  def self.render_tabs(view)
    selected_tab_name = selected_tab(view).name
    html = '<ul id="tabs">'
    for tab in main_tabs
      next if !tab.visible?(view)
      klass = ''
      if tab.name == selected_tab_name
        klass << 'active'
      else
        klass << 'inactive'
      end
      if tab.enabled?(view)
        klass << ' enabled'
      else
        klass << ' disabled'
      end
      html << %Q{<li class="#{klass}">}
      html << '<span class="tab">'
      # TODO: add an option where the tab remains clickable
      #if tab.name == selected_tab_name
      #  html << tab.text
      #else
        html << %Q{<a href="#{tab.path}">#{tab.text}</a>}
      #end
      html << '</span></li>'
    end
    html << '</ul>'
    view.raw(html)
  end
  
  def self.render_subtabs(view)
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    tab = selected_tab(view)
    html = ''
    html << '<div id="subnav"><ul id="subtabs">'
    for subtab in tab.subtabs
      next if !subtab.visible?(view)
      klass = ''
      subselected = selected?(controller, action, subtab.name)
      if subselected
        klass << 'active'
      else
        klass << 'inactive'
      end
      if subtab.enabled?(view)
        klass << ' enabled'
      else
        klass << ' disabled'
      end
      html << %Q{<li class="#{klass}">}
      html << '<span class="tab">'
      if subselected
        html << subtab.text
      else
        html << %Q{<a href="#{subtab.path}">#{subtab.text}</a>}
      end
      html << '</span></li>'
    end
    html << '</ul></div>'
    view.raw(html)
  end
  
  def self.selected?(controller, action, tab_name)
    if @@actions[controller][action].nil? && !@@actions[controller][:all_actions]
      # TODO: better error message or perhaps don't render tabs
      raise "No tab is defined for controller '#{controller}' action '#{action}'"
    end
    (@@actions[controller][action] && @@actions[controller][action].include?(tab_name)) ||
     (@@actions[controller][:all_actions] && @@actions[controller][:all_actions].include?(tab_name))
  end
  
  class Tab
    
    attr_reader :name, :text, :path, :parent
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
    
    def visible?(view)
      if @visible.is_a? Proc
        view.instance_eval &@visible
      else
        !!@visible
      end
    end
    
    def enabled?(view)
      if @enabled.is_a? Proc
        view.instance_eval &@enabled
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

ActiveSupport.on_load(:action_view) { include Tabulous::Helpers }
