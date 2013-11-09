module Tabulous
  class CssScaffolding

    def self.embeddable_styles
      %Q{
        <style type="text/css">

        body {
          margin: 0;
          padding: 0;
        }

        .tabs, .tabs ul, .tabs ul li, .tabs ul li span, .tabs ul li a,
        .subtabs, .subtabs ul, .subtabs ul li, .subtabs ul li span, .subtabs ul li a {
          margin: 0;
          padding: 0;
          line-height: 1;
        }

        .tabs, .tabs a, .tabs a:visited, .tabs a:hover {
          color: #{Config.text_color};
        }

        .tabs li.disabled, .tabs li.disabled a, .tabs li.disabled a:visited, .tabs li.disabled a:hover,
        .subtabs li.disabled, .subtabs li.disabled a, .subtabs li.disabled a:visited, .subtabs li.disabled a:hover {
          color: #{Config.inactive_text_color};
        }

        .tabs a {
          text-decoration: none;
        }

        .tabs ul {
          font-size: 24px;
          height: 57px;
          list-style-type: none;
          background-color: #{Config.background_color};
          padding: 0 0 0 50px;
        }

        .tabs ul li {
          padding-top: 25px;
          padding-right: 5px;
          float: left;
        }

        .tabs ul li .tab {
          background-color: #{Config.inactive_tab_color};
          padding: 5px 15px 3px 15px;
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

        .tabs ul li.active .tab {
          background-color: #{Config.active_tab_color};
          padding-bottom: 14px;
        }

        .tabs ul li a:hover {
          background-color: #{Config.hover_tab_color};
        }

        .tabs ul, .subtabs ul {
          /* float clearing */
          overflow: hidden;
          display: inline-block; /* Necessary to trigger "hasLayout" in IE */
          display: block; /* Sets element back to block */
        }

        .subtabs ul {
          margin-top: 5px;
        }

        .subtabs, .subtabs a, .subtabs a:visited {
          color: #{Config.text_color};
        }

        .subtabs li.active {
          font-weight: bold;
        }

        .subtabs a {
          text-decoration: none;
        }

        .subtabs ul {
          font-size: 16px;
          height: 30px;
          list-style-type: none;
          padding: 0 0 0 50px;
        }

        .subtabs ul li {
          padding: 10px;
          float: left;
        }

        .subtabs ul li a:hover {
          text-decoration: underline;
        }

        </style>
      }
    end

  end
end
