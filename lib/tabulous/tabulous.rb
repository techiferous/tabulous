module Tabulous

  def self.setup
    yield self
  end
  
  def self.tabs(&block)
    @@tabs_block = block
  end

  def self.actions(&block)
    @@actions_block = block
  end

  def self.render_tabs(view)
    initialize_tabs(view)
    return if !tab_defined?(view) && @@when_action_has_no_tab == :do_not_render
    html = ''
    html << embed_styles
    active_tab = active_tab(view)
    active_tab_name = (active_tab ? active_tab.name : nil);
    html << (@@html5 ? '<nav id="tabs">' : '<div id="tabs">')
    if @@tabs_ul_class
      html << %Q{<ul class="#{@@tabs_ul_class}">}
    else
      html << '<ul>'
    end
    for tab in main_tabs
      next if !tab.visible?(view)
      if @@bootstrap_style_subtabs
        subtabs = tab.subtabs.select{|subtab| subtab.visible?(view)}
      end
      if @@bootstrap_style_subtabs && !subtabs.empty?
        html << render_dropdown_tab(view,
                                    :text => tab.text(view),
                                    :path => tab.path(view),
                                    :active => (active_tab_name && tab.name == active_tab_name),
                                    :enabled => tab.enabled?(view),
                                    :subtabs => subtabs)
      else
        html << render_tab(:text => tab.text(view),
                           :path => tab.path(view),
                           :active => (active_tab_name && tab.name == active_tab_name),
                           :enabled => tab.enabled?(view))
      end
    end
    html << '</ul>'
    html << (@@html5 ? '</nav>' : '</div>')
    view.raw(html)
  end
  
  def self.render_subtabs(view)
    if @@bootstrap_style_subtabs
      raise TabulousError,
            "You should not call the subtabs view helper when config.bootstrap_style_subtabs " +
            "is set to true.  Simply call the tabs helper and the subtabs will be " +
            "automatically rendered."
    end
    initialize_tabs(view)
    return if !tab_defined?(view) && @@when_action_has_no_tab == :do_not_render
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    tab = active_tab(view)
    html = ''
    html << (@@html5 ? '<nav id="subtabs">' : '<div id="subtabs">')
    if @@subtabs_ul_class
      html << %Q{<ul class="#{@@subtabs_ul_class}">}
    else
      html << '<ul>'
    end
    if tab.nil?
      subtabs = []
    else
      subtabs = tab.subtabs.select{|subtab| subtab.visible?(view)}
    end
    return if subtabs.empty? && !@@always_render_subtabs
    for subtab in subtabs
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
    if (options[:active] && !@@active_tab_clickable) || options[:enabled] == false
      html << %Q{<span class="tab">#{options[:text]}</span>}
    else
      html << %Q{<a href="#{options[:path]}" class="tab">#{options[:text]}</a>}
    end
    html << '</li>'
    html
  end

  # markup spefically tailored for Twitter Bootstrap
  def self.render_dropdown_tab(view, options)
    html = ''
    klass = 'dropdown'
    klass << (options[:active] ? ' active' : ' inactive')
    klass << (options[:enabled] ? ' enabled' : ' disabled')
    html << %Q{<li class="#{klass}">}
    if (options[:active] && !@@active_tab_clickable) || options[:enabled] == false
      html << %Q{<span class="tab">#{options[:text]}</span>}
    else
      html << %Q{<a class="dropdown-toggle tab"}
      html << %Q{   data-toggle="dropdown"}
      html << %Q{   href="#">}
      html << %Q{#{options[:text]}<b class="caret"></b></a>}
    end
    html << '<ul class="dropdown-menu">'
    for subtab in options[:subtabs]
      if subtab.enabled?(view)
        html << '<li class="enabled">'
      else
        html << '<li class="disabled">'
      end
      html << %Q{<a href="#{subtab.path(view)}">#{subtab.text(view)}</a>}
      html << '</li>'
    end
    html << '</ul>'
    html << '</li>'
    html
  end

  def self.initialize_tabs(view)
    if view.respond_to? :instance_exec # for Ruby 1.9
      self.tabs = view.instance_exec(&@@tabs_block)
      self.actions = view.instance_exec(&@@actions_block)
    else
      self.tabs = view.instance_eval(&@@tabs_block)
      self.actions = view.instance_eval(&@@actions_block)
    end
  end

  def self.tabs=(ary)
    @@tabs = []
    last_tab = nil
    ary.each do |tab_args|
      begin
        tab = Tab.new(*tab_args)
      rescue ArgumentError
        raise ColumnError,
              "Your config.tabs table is improperly formatted.  You probably have " +
              "the wrong number of columns.  Or, in other words, one of the arrays " +
              "in the config.tabs array has the wrong number of elements."
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
    ary.each do |a|
      if a.size != 3
        raise ColumnError,
              "Your config.actions table is improperly formatted.  You probably have " +
              "the wrong number of columns.  Or, in other words, one of the arrays " +
              "in the config.actions array has the wrong number of elements."
      end
    end
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

  def self.active?(controller, action, tab_name)
    return false if @@actions[controller].nil?
    (@@actions[controller][action] && @@actions[controller][action].include?(tab_name)) ||
    (@@actions[controller][:all_actions] && @@actions[controller][:all_actions].include?(tab_name))
  end

  def self.tab_defined?(view)
    controller = view.controller_name.to_sym
    action = view.action_name.to_sym
    if @@actions[controller].nil?
      if @@when_action_has_no_tab == :raise_error
        raise NoTabFoundError,
              "No tabs are defined for the controller '#{controller}'.  " +
              "You can define a tab for this controller in app/tabs/tabulous.rb " +
              "in the 'config.actions =' section.  You can also turn off NoTabFoundErrors " +
              "by changing the value of config.when_action_has_no_tab."
      else
        return false
      end
    end
    if @@actions[controller][action].nil? && !@@actions[controller][:all_actions]
      if @@when_action_has_no_tab == :raise_error
        raise NoTabFoundError,
              "No tab is defined for the action '#{action}' in the controller '#{controller}'.  " +
              "You can define a tab for this action in app/tabs/tabulous.rb " +
              "in the 'config.actions =' section.  You can also turn off NoTabFoundErrors " +
              "by changing the value of config.when_action_has_no_tab."
      else
        return false
      end
    end
    tab = active_tab(view)
    if tab.nil?
      alleged_tab = @@actions[controller][action]
      if alleged_tab.nil?
        alleged_tab = @@actions[controller][:all_actions]
      end
      raise UnknownTabError,
            "You've hooked the action '#{action}' in controller '#{controller}' to " +
            "the tab '#{alleged_tab}', but this tab is not defined."
    end
    true
  end

end
