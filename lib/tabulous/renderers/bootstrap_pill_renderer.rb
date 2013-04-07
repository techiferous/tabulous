require 'active_support/core_ext/string'

module Tabulous
  class BootstrapPillRenderer < BootstrapRenderer

    def tabs_html
      <<-HTML.strip_heredoc
        <ul class="nav nav-pills">
          #{ tab_list_html }
        </ul>
      HTML
    end

  end
end
