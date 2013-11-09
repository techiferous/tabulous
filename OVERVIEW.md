# Tabulous Overview

## Why Tabulous Exists

Tabulous was created so that you can quickly create a tabbed navigation bar with minimal effort.  It is perfect for quick prototyping, robust enough for production use, and flexible enough to grow with your app.

## When to Use Tabulous

Tabulous is the right tool for the job if:

* you want to click on a tab to take you to a different page (URL) in your app

Tabulous is the wrong tool for the job if:

* you want to use Ajax to switch tabs
* you want to embed tabbed content within a page

## The Basics

You describe your tabs in app/tabs/tabulous.rb like this:

    Tabulous.setup do

      tabs do
        pictures_tab do
          text          { 'My Pictures' }
          link_path     { root_path }
          visible_when  { true }
          enabled_when  { true }
          active_when   { in_action('any').of_controller('pictures') }
        end

        music_tab do
          text          { 'My Music' }
          link_path     { songs_path }
          visible_when  { true }
          enabled_when  { current_user.has_music? }
          active_when   { a_subtab_is_active }
        end

        songs_subtab do
          text          { 'Songs' }
          link_path     { songs_path }
          visible_when  { true }
          enabled_when  { true }
          active_when   { in_action('any').of_controller('songs') }
        end

        artists_subtab do
          text          { 'Artists' }
          link_path     { artists_path }
          visible_when  { true }
          enabled_when  { true }
          active_when   { in_action('any').of_controller('artists') }
        end

        account_tab do
          text          { 'My Account' }
          link_path     { account_path(current_user) }
          visible_when  { true }
          enabled_when  { true }
          active_when   { in_actions('show', 'edit', 'update').of_controller('user_profiles') }
        end

        admin_tab do
          text          { 'Admin' }
          link_path     { admin_path }
          visible_when  { current_user.admin? }
          enabled_when  { true }
          active_when   { in_action('any').of_controller('admin') }
        end
      end

    end

Then, in your layout, you render the tabs like this:

    <%= tabs %>
    <%= subtabs %>

This will produce markup that looks like this:

    <div class="tabs">
      <ul>
        <li class="disabled">
          <span class="tab">My Pictures</span>
        </li>
        <li class="active">
          <a href="/songs" class="tab">My Music</a>
        </li>
        <li>
          <a href="/account" class="tab">My Account</a>
        </li>
        <li>
          <a href="/admin" class="tab">Admin</a>
        </li>
      </ul>
    </div>

    <div class="subtabs">
      <ul>
        <li>
          <a href="/songs" class="tab">Songs</a>
        </li>
        <li>
          <a href="/artists" class="tab">Artists</a>
        </li>
      </ul>
    </div>

## Getting Started

### Installing

Add tabulous to your Gemfile:

    gem 'tabulous'

And install the gem:

    $ bundle install

### Tabs

Run the tabulous generator:

    $ rails generate tabs

This creates app/tabs/tabulous.rb.  The generator guesses what your tabs might look like based on your controllers.  So you'll need to edit this file.

Tabs are displayed in the order they appear.  So if you want a set of tabs that looks like this:

      ____________   ____________   __________
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

For each tab, you must specify these five declarations:

* **text** -- what words to put on the tab
* **link_path** -- where to go when you click the tab
* **visible_when** -- whether to draw the tab at all
* **enabled_when** -- when this tab should not be clickable
* **active_when** -- when this tab should appear selected

Let's say you wanted the unicorns tab to:

* take you to '/unicorns' when clicked
* be visible only if the user loves unicorns
* be enabled only if it's May
* and be active whenever the UnicornsController ends up rendering the page.

Your tab declaration would look like this:

    unicorns_tab do
      text          { 'Unicorns' }
      link_path     { '/unicorns' }
      visible_when  { current_user.loves_unicorns? }
      enabled_when  { Time.now.month == 5 }
      active_when   { in_action('any').of_controller('unicorns') }
    end

All of the blocks above (except for active_when) are executed in the context of your view layout, so any helper methods such as current_user or unicorns_path would be available.

Read the [REFERENCE](REFERENCE.md) for more details.

### Subtabs

Let's say you wanted to add two subtabs to the rainbows tab.  Do this by adding the tabs right after the rainbows tab and making sure their names end with _subtab:

    rainbows_tab do
      text          { 'Rainbows' }
      link_path     { rainbows_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { a_subtab_is_active }
    end

    monorainbows_subtab do
      text          { 'Monorainbows' }
      link_path     { monorainbows_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('monorainbows') }
    end

    double_rainbows_subtab do
      text          { 'Double Rainbows' }
      link_path     { double_rainbows_path}
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('double_rainbows') }
    end

Note also that the active_when declaration in rainbows_tab must contain a_subtab_is_active since it has subtabs.

Read the [REFERENCE](REFERENCE.md) for more details.

### Rendering

Put these somewhere in your layout:

    <%= tabs %>
    <%= subtabs %>

They do not have to appear together.

Each tab is wrapped in an li tag.  If the tab is disabled, its li tag will have a "disabled" class.  If the tab is selected, its li tag will have an "active" class.

If you used the generator to create your tabulous.rb file, you'll see the following:

    use_css_scaffolding do
      background_color '#ccc'
      text_color '#444'
      active_tab_color '#fff'
      hover_tab_color '#ddd'
      inactive_tab_color '#aaa'
      inactive_text_color '#888'
    end

This puts some inline CSS into your web page to give your tabs some basic styling.  The purpose of the CSS scaffolding is quick prototyping.  It should eventually be removed and replaced by your own CSS.  Just delete the use_css_scaffolding block.

Read the [REFERENCE](REFERENCE.md) for more details.

### Advanced Usage

You can customize the behavior of tabulous by adding a customize block inside Tabulous.setup:

    customize do
      renderer :bootstrap                      # generate Twitter Bootstrap-style HTML for tabs
      active_tab_clickable = false             # don't allow the selected tab to be clicked
      when_action_has_no_tab = :raise_error    # error out if there is no selected tab
      render_subtabs_when_empty = true         # always include subtab markup, even if empty
    end

Read the [REFERENCE](REFERENCE.md) for more details.

## Software Design Decisions

### Controller Actions Drive Tab Selection

Which tab is selected depends on the controller action that rendered the current view.  This is a deliberate design decision that works very well in the vast majority of use cases.  For the edge cases, it's usually easy enough to adjust your controller actions to conform to this expectation.

### Separated

Rendering a tab navigation bar is a view concern, not a controller concern, so tab-related code should not appear in controllers at all.  Also, consolidating all of the tab behavior into the tabulous.rb file keeps complex logic out of your views.

### Simple

Tabulous is not designed to handle all tab-related use cases.  It is designed to have features for common use cases and provide options to override default behavior.  This keeps tabulous simple enough to be learned quickly and used for easy prototyping.  Tabulous does, however, aim to be complete enough and flexible enough so that most applications will never have to replace it with custom tab code.

### Harmonious

Tabulous aims to integrate well in a variety of situations, which is why it supports Twitter Bootstrap, allows for you to generate custom tab HTML, and works with many versions of Rails and Ruby.

### Declarative

Tabulous uses a declarative DSL such as is used by config/routes.rb.  Using a declarative style makes it easy to specify _what_ your tabs should do without exposing anything about _how_ tabulous does it.  It also makes the code short and readable.
