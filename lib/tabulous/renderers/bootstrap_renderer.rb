require 'active_support/core_ext/string'

module Tabulous
  class BootstrapRenderer < CombinedRenderer

    def tabs_html
      <<-HTML.strip_heredoc
        <ul class="nav nav-tabs">
          #{ tab_list_html }
        </ul>
      HTML
    end

  protected

    def tab_html(tab)
      return '' unless tab.visible?(@view)
      html = ''
      klass = ''
      klass << 'active' if tab.active?(@view)
      klass << ' disabled' unless tab.enabled?(@view)
      klass << ' dropdown' if tab.subtabs.any?
      klass.strip!
      if klass.empty?
        html << '<li>'
      else
        html << %Q{<li class="#{klass}">}
      end
      if tab.subtabs.empty?
        html << tab_link(tab)
      else
        html << tab_link_with_subtabs(tab)
      end
      html << "</li>"
      html
    end

    def tab_link(tab)
      html = ''
      if tab.clickable?(@view) && tab.enabled?(@view)
        html << %Q{<a href="#{tab.link_path(@view)}">#{tab.text(@view)}</a>}
      else
        html << %Q{<a>#{tab.text(@view)}</a>}
      end
      html
    end

    def tab_link_with_subtabs(tab)
      html = ''
      html << %Q{<a class="dropdown-toggle" data-toggle="dropdown" href="#">#{tab.text(@view)}<b class="caret"></b></a>}
      html << %Q{<ul class="dropdown-menu">}
      for subtab in tab.subtabs
        next unless subtab.visible?(@view)
        klass = (subtab.enabled?(@view) ? '' : 'disabled')
        if klass.empty?
          html << '<li>'
        else
          html << %Q{<li class="#{klass}">}
        end
        html << tab_link(subtab)
        html << "</li>"
      end
      html << "</ul>"
      html
    end

  end
end
