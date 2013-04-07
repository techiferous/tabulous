module Tabulous
  class Html5Renderer < DefaultRenderer

    def tabs_html
      <<-HTML.strip_heredoc
        <nav class="tabs">
          <ul>
            #{ tab_list_html }
          </ul>
        </nav>
      HTML
    end

    def subtabs_html
      <<-HTML.strip_heredoc
        <nav class="subtabs">
          <ul>
            #{ subtab_list_html }
          </ul>
        </nav>
      HTML
    end

  end
end
