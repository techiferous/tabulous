# Tabulous Reference

## Contents

* [Tabsets](#tabsets)
    * [Multiple Tabsets](#multiple-tabsets)
    * [Tab Order](#tab-order)
    * [Subtabs](#subtabs)
    * [Tab Names](#tab-names)
* [Tab Declarations](#tab-declarations)
    * [text](#text)
    * [link_path](#link_path)
    * [visible_when](#visible_when)
    * [enabled_when](#enabled_when)
    * [active_when](#active_when)
* [Customizing](#customizing)
    * [renderer](#renderer)
    * [active_tab_clickable](#active_tab_clickable)
    * [when_action_has_no_tab](#when_action_has_no_tab)
    * [render_subtabs_when_empty](#render_subtabs_when_empty)
* [CSS Scaffolding](#css-scaffolding)
* [Helpers](#helpers)
* [Generators](#generators)

## Tabsets

A tabbed navigation bar, which we will call a tabset, is specified using a tabs block:

    tabs do
      unicorns_tab do
        ...
      end

      rainbows_tab do
        ...
      end
    end

### Multiple Tabsets

You can have more than one tabset on a page by passing in a name to the tabs block:

    tabs(:fun) do
      unicorns_tab do
        ...
      end

      rainbows_tab do
        ...
      end
    end

    tabs(:colors) do
      red_tab do
        ...
      end

      blue_tab do
        ...
      end
    end

Then, in your layout, you need to tell tabulous which tabset to draw:

    <%= tabs(:fun) %>
    <%= subtabs(:fun) %>
    <p>some markup</p>
    <%= tabs(:colors) %>
    <%= subtabs(:colors) %>

### Tab Order

Tabs are displayed in the order they appear.  So if you want a set of tabs that looks like this:

     ,____________, ,____________, ,__________,
    _|  UNICORNS  |_|  RAINBOWS  |_|  PONIES  |_

your tabs block should look like this:

    tabs do
      unicorns_tab do
        ...
      end

      rainbows_tab do
        ...
      end

      ponies_tab do
        ...
      end
    end

### Subtabs

Any tab can have several subtabs associated with it that become visible when the parent tab is clicked.  Declare subtabs just like tabs, except make sure that their name ends in _subtab.  Subtabs should be declared immediately after their parent tab.  Parent tabs must include a_subtab_is_active in their active_when declaration:

    tabs do
      unicorns_tab do
        ...
      end

      rainbows_tab do
        ...
        active_when { a_subtab_is_active }
      end

      monorainbows_subtab do
        ...
      end

      double_rainbows_subtab do
        ...
      end

      ponies_tab do
        ...
        active_when { a_subtab_is_active }
      end

      shetland_ponies_subtab do
        ...
      end
    end

### Tab Names

It doesn't matter what you call a tab, but it must end in \_tab or \_subtab, and it can't have the same name as another tab.

    tabs do
      unicorns do  # BAD: does not end in _tab
        ...
      end

      rainbows_tab do
        ...
      end
    end

## Tab Declarations

Each tab has five declarations that you must specify.  The text, link_path, visible_when and enabled_when declarations do not need to be given a block.  If given a block, the block will be executed in the context of the layout where the tabs are rendered.

Here is an example of a tab with the five required declarations:

    unicorns_tab do
      text          'Unicorns'
      link_path     '/unicorns'
      visible_when  { current_user.loves_unicorns? }
      enabled_when  true
      active_when   { in_action('any').of_controller('unicorns') }
    end

### text

text must evaluate to a string.  This string will be what users see written on the tab.

### link_path

link_path must evaluate to a string which is a valid URL or path.  This is the URL that the browser will load when the tab is clicked.

    narwhals_tab do
      ...
      link_path  { narwhals_path }
      ...
    end

Since a block given to link_path is evaluated in the context of a view layout and not any particular view, you should not reference HTTP params:

    narwhal_tab do
      ...
      link_path  { narwhal_path(params[:narwhal_id]) }  # WRONG
      ...
    end

### visible_when

If visible_when evaluates to false (or a falsy value like nil), the HTML for that particular tab will not be generated.

### enabled_when

If enabled_when evaluates to false (or a falsy value like nil), li tag for that tab will have a "disabled" class.

### active_when

Tabulous sets a tab as active depending on the controller action that generated the web page.  active_when should list out all of the actions for which the tab should be selected:

    unicorns_tab do
      ...
      active_when do
        in_action('index').of_controller('unicorns')
        in_action('show').of_controller('unicorns')
        in_action('new').of_controller('unicorns')
        in_action('create').of_controller('unicorns')
        in_action('edit').of_controller('unicorns')
        in_action('update').of_controller('unicorns')
        in_action('destroy').of_controller('unicorns')
      end
    end

As a convenience, you can list more than one action at a time using in_actions:

    unicorns_tab do
      ...
      active_when  { in_actions('index', 'show', 'new', 'create', 'edit', 'update', 'destroy').of_controller('unicorns') }
    end

Since it is common for there to be a one-to-one correspondence between a controller and a tab, you can list the 'any' action as a catch-all:

    unicorns_tab do
      ...
      active_when  { in_action('any').of_controller('unicorns') }
    end

The actions that make the tab active do not have to be limited to one controller:

    unicorns_tab do
      ...
      active_when do
        in_action('any').of_controller('unicorns')
        in_action('show').of_controller('horses')
      end
    end

Namespaced controllers, such as Admin::UserAccountsController, can be referenced like so:

    unicorns_tab do
      ...
      active_when  { in_action('any').of_controller('admin/user_accounts') }
    end

It is an error for active_when rules of different tabs to overlap or conflict with each other:

    unicorns_tab do
      ...
      active_when  { in_action('any').of_controller('unicorns') }
    end

    list_unicorns_tab do
      ...
      active_when  { in_action('index').of_controller('unicorns') }  # WRONG, conflicts with above active_when
    end

If a tab has subtabs, it is automatically set to active if any of its subtabs is active.  To make this behavior explicit, the parent tab must specify a_subtab_is_active as one of the rules in active_when.

## Customizing

Tabulous tries to provide good default behavior to make it easy to quickly add tabs to your app.  Tabulous gives you control over some of its choices if you don't like the defaults.

### renderer

This specifies the class that the tabs and subtabs view helpers use to generate the tab markup.

    customize do
      renderer :default
    end

There are three other renderers you can use:

* **:html5** -- uses nav tags instead of divs
* **:bootstrap** -- generates markup compatible with Twitter Bootstrap; it uses the "nav-tabs" class
* **:bootstrap_pill** -- generates markup compatible with Twitter Bootstrap; it uses the "nav-pills" class

If this doesn't suit your needs, you can write your own custom renderer.  Here's an example of a custom renderer class:

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

Put this class in app/tabs alongside the tabulous.rb file.  To use this, pass the underscored name of the renderer class (without renderer) to the customize block:

    customize do
      renderer :custom
    end

You do not have to call the class CustomRenderer.  For example, if you specified this renderer:

    customize do
      renderer :double_rainbow
    end

tabulous will look for a class called DoubleRainbowRenderer when generating markup for tabs.

The best way to understand how to write a custom renderer is to look at [the tabulous gem code](https://github.com/techiferous/tabulous/tree/master/lib/tabulous/renderers) at how the various tabulous renderers are written.

### active_tab_clickable

By default, the active tab is clickable.  If you want to prevent the active tab from being clicked, set this to false:

    customize do
      active_tab_clickable false
    end

### when_action_has_no_tab

When tabulous tries to set a tab active based on the current controller action and it can't find any tab that says it should be active, by default tabulous does not render the tabset at all:

    customize do
      when_action_has_no_tab :do_not_render
    end

This default makes multiple tabsets play nicely with each other.  If you want to consider not finding an active tab to be an error, you can tell tabulous to raise an error:

    customize do
      when_action_has_no_tab :raise_error
    end

Finally, if you want tabulous to draw the tabs anyway, even though none of them are active, you can:

    customize do
      when_action_has_no_tab :render
    end

### render_subtabs_when_empty

By default, tabulous does not include any subtab markup at all if no subtabs are visible.  If you always want subtab HTML to appear in the page, even if there is nothing in the list of subtabs, set render_subtabs_when_empty to true:

    customize do
      render_subtabs_when_empty true
    end

## CSS Scaffolding

If you are prototyping a new app and want your tabs to instantly look decent, tabulous provides you with quick and dirty CSS that you can turn on by specifying use_css_scaffolding in your Tabulous.setup block:

    Tabulous.setup do

      tabs do
        ...
      end

      customize do
        ...
      end

      use_css_scaffolding

    end

You can customize the colors:

    use_css_scaffolding do
      background_color '#cec'
      text_color '#464'
      active_tab_color '#fff'
      hover_tab_color '#dfd'
      inactive_tab_color '#aca'
      inactive_text_color '#8a8'
    end

You should turn off the CSS scaffolding and use your own CSS before launching your web app, since the scaffolded CSS is placed directly inside your HTML page, which is technically invalid HTML.

## Helpers

Tabulous generates HTML for you to place in your layout.  It does this with the following helpers:

    <%= tabs %>
    <%= subtabs %>

If you have multiple tabsets, you need to call these helpers for each tabset:

    <%= tabs(:fun) %>
    <%= subtabs(:fun) %>

    <%= tabs(:colors) %>
    <%= subtabs(:colors) %>

Some renderers, like the Twitter Bootstrap renderers, generate markup that has subtabs interspersed within tabs instead of a separate list of tabs and subtabs.  If a renderer does this, it is an error to call the subtabs helper:

    <%= tabs %>     # always ok
    <%= subtabs %>  # DO NOT DO THIS if using a Bootstrap renderer

## Generators

Tabulous comes with one generator that will create an app/tabs/tabulous.rb file based on your controllers:

    rails generate tabs
