module Tabulous
  def self.embed_styles
    return '' unless @@css.scaffolding
    %Q{
      <style type="text/css">
      
      body {
        margin: 0;
        padding: 0;
      }
      
      ##{@@wrapper_id}, ##{@@wrapper_id} ul, ##{@@wrapper_id} ul li, ##{@@wrapper_id} ul li span, ##{@@wrapper_id} ul li a,
      #subtabs, #subtabs ul, #subtabs ul li, #subtabs ul li span, #subtabs ul li a {
        margin: 0;
        padding: 0;
        line-height: 1;
      }

      ##{@@wrapper_id}, ##{@@wrapper_id} a, ##{@@wrapper_id} a:visited, ##{@@wrapper_id} a:hover {
        color: #{@@css.text_color};
      }

      ##{@@wrapper_id} li.disabled, ##{@@wrapper_id} li.disabled a, ##{@@wrapper_id} li.disabled a:visited, ##{@@wrapper_id} li.disabled a:hover,
      #subtabs li.disabled, #subtabs li.disabled a, #subtabs li.disabled a:visited, #subtabs li.disabled a:hover {
        color: #{@@css.inactive_text_color};
      }

      ##{@@wrapper_id} a {
        text-decoration: none;
      }

      ##{@@wrapper_id} ul {
        font-size: 24px;
        height: 57px;
        list-style-type: none;
        background-color: #{@@css.background_color};
        padding: 0 0 0 50px;
      }

      ##{@@wrapper_id} ul li {
        padding-top: 25px;
        padding-right: 5px;
        float: left;
      }

      ##{@@wrapper_id} ul li .tab {
        background-color: #{@@css.inactive_tab_color};
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

      ##{@@wrapper_id} ul li.active .tab {
        background-color: #{@@css.active_tab_color};
        padding-bottom: 14px;
      }

      ##{@@wrapper_id} ul li a:hover {
        background-color: #{@@css.hover_tab_color};
      }

      ##{@@wrapper_id} ul {
        /* float clearing */
        overflow: hidden;
        display: inline-block; /* Necessary to trigger "hasLayout" in IE */
        display: block; /* Sets element back to block */
      }

      #subtabs ul {
        margin-top: 5px;
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
