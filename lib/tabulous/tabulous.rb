module Tabulous

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
        raise FormattingError,
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
        raise FormattingError,
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
    subtabs = tab.subtabs.select{|subtab| subtab.visible?(view)}
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

end
