require 'active_support/core_ext/string'

module Tabulous
  class DefaultRenderer < SplitRenderer

    def tabs_html
      <<-HTML.strip_heredoc
        <div class="tabs">
          <ul>
            #{ tab_list_html }
          </ul>
        </div>
      HTML
    end

    def subtabs_html
      <<-HTML.strip_heredoc
        <div class="subtabs">
          <ul>
            #{ subtab_list_html }
          </ul>
        </div>
      HTML
    end

  protected

    def tab_html(tab)
      return '' unless tab.visible?(@view)
      html = ''
      klass = ''
      klass << 'active' if tab.active?(@view)
      klass << ' disabled' unless tab.enabled?(@view)
      klass.strip!
      if klass.empty?
        html << '<li>'
      else
        html << %Q{<li class="#{klass}">}
      end
      if tab.clickable?(@view)
        html << %Q{<a href="#{tab.link_path(@view)}" class="tab">#{tab.text(@view)}</a>}
      else
        html << %Q{<span class="tab">#{tab.text(@view)}</span>}
      end
      html << "</li>"
      html
    end

  end
end
