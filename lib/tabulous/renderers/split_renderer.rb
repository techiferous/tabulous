# A "split" renderer is one that produces two different HTML fragments:
# one for the tabs, another for the subtabs.
#
# "Combined" renderers would embed the subtab HTML straight into the HTML for
# the tabs, producing just one HTML fragment.
#
# This class is meant to be subclassed.  It encapsulates the code
# common to all split renderers so that it doesn't have to be recoded
# everytime.

module Tabulous
  class SplitRenderer

    def initialize(tabset, view)
      @view = view
      @tabset = tabset
    end

    def tabs_html
      raise "override me"
    end

    def subtabs_html
      raise "override me"
    end

  protected

    def tab_html(tab)
      raise "override me"
    end

    def tab_list_html
      html = ''
      for tab in @tabset.primary_tabs
        html << tab_html(tab)
      end
      html
    end

    def subtab_list_html
      html = ''
      for tab in subtabs
        html << tab_html(tab)
      end
      html
    end

    def subtabs
      @tabset.visible_subtabs(@view)
    end

  end
end
