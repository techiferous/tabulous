class CustomRenderer < Tabulous::DefaultRenderer

  def tabs_html
    <<-HTML.strip_heredoc
      <div class="tabs" class="from_custom_renderer">
        <ul>
          #{ tab_list_html }
        </ul>
      </div>
    HTML
  end

  def subtabs_html
    <<-HTML.strip_heredoc
      <div class="subtabs" class="from_custom_renderer">
        <ul>
          #{ subtab_list_html }
        </ul>
      </div>
    HTML
  end

protected

  def tab_html(tab)
    return '<li>stub</li>'
  end

end
