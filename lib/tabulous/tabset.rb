module Tabulous
  class Tabset

    def initialize
      @tabs = []
    end

    def add_tab(tab)
      if @tabs.map(&:name).include?(tab.name)
        raise TabNameError, "There is already a tab named '#{tab.name}'."
      end
      @tabs << tab
    end

    def tabs
      @tabs
    end

    def primary_tabs
      @tabs.reject(&:subtab?)
    end

    def active_primary_tab(view)
      for tab in primary_tabs
        return tab if tab.active?(view)
      end
      nil
    end

    def visible_subtabs(view)
      if active_primary_tab(view).nil?
        []
      else
        active_primary_tab(view).subtabs.select{|subtab| subtab.visible?(view)}
      end
    end

  end
end
