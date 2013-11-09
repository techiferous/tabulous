require 'active_support/core_ext/string'

module Tabulous
  class BootstrapNavbarRenderer < BootstrapRenderer

    def tabs_html
      <<-HTML.strip_heredoc
        <ul class="nav navbar-nav">
          #{ tab_list_html }
        </ul>
      HTML
    end

  end
end
