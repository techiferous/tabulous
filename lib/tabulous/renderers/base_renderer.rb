# This holds common behavior for all renderer classes.

module Tabulous
  class BaseRenderer

    def initialize(tabset, view)
      @view = view
      @tabset = tabset
    end

    # all renderers need to have a tabs_html method that returns the
    # HTML to be embedded when the <%= tabs %> helper method is called
    def tabs_html
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

    def tab_url(tab)
      tab.link_path(@view)
    end

    def tab_http_verb_attributes(tab)
      return '' if tab.http_verb == :get
      %Q{data-method="#{tab.http_verb}"}
    end

    def tab_text(tab)
      tab.text(@view)
    end

  end
end
