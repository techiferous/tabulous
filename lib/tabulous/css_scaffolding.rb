module Tabulous
  def self.embed_styles
    return '' unless @@css.scaffolding
    %Q{
      <style type="text/css">
      body, #tabs, #tabs ul, #tabs ul li, #tabs ul li span, #tabs ul li span a,
      #subtabs, #subtabs ul, #subtabs ul li, #subtabs ul li span, #subtabs ul li span a {
        margin: 0;
        padding: 0;
      }

      #tabs, #tabs a, #tabs a:visited, #tabs a:hover {
        color: #{@@css.text_color};
      }

      #tabs li.disabled, #tabs li.disabled a, #tabs li.disabled a:visited, #tabs li.disabled a:hover,
      #subtabs li.disabled, #subtabs li.disabled a, #subtabs li.disabled a:visited, #subtabs li.disabled a:hover {
        color: #{@@css.inactive_text_color};
      }

      #tabs a {
        text-decoration: none;
      }

      #tabs ul {
        font-size: 24px;
        height: 59px;
        list-style-type: none;
        background-color: #{@@css.background_color};
        padding: 0 0 0 50px;
      }

      #tabs ul li {
        padding-top: 25px;
        padding-right: 5px;
        float: left;
      }

      #tabs ul li .tab {
        padding: 5px 15px 0px 15px;
        float: left;
      	-webkit-border-top-left-radius: 8px;
      	-khtml-border-radius-topleft: 8px;	
      	-moz-border-radius-topleft: 8px;
      	border-top-left-radius: 8px;
      	-webkit-border-top-right-radius: 8px;
      	-khtml-border-radius-topright: 8px;	
      	-moz-border-radius-topright: 8px;
      	border-top-right-radius: 8px;
      }

      #tabs ul li .tab {
        background-color: #{@@css.inactive_tab_color};
      }

      #tabs ul li.active .tab {
        background-color: #{@@css.active_tab_color};
        padding-bottom: 16px;
      }

      #tabs ul li a:hover {
        background-color: #{@@css.hover_tab_color};
      }

      #subtabs ul {
        margin-top: 15px;
      }

      #subtabs, #subtabs a, #subtabs a:visited {
        color: #{@@css.text_color};
      }

      #subtabs li.active {
        font-weight: bold;
      }

      #subtabs a {
        text-decoration: none;
      }

      #subtabs ul {
        font-size: 16px;
        height: 30px;
        list-style-type: none;
        padding: 0 0 0 50px;
      }

      #subtabs ul li {
        padding: 10px;
        float: left;
      }

      #subtabs ul li a:hover {
        text-decoration: underline;
      }

      </style>
    }
  end
end
