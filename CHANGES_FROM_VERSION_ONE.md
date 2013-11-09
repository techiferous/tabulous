# Changes From Version One

Tabulous 2 introduces significant, non-backwards-compatible changes.  If you are using an earlier version of tabulous, you will have to make some code changes when upgrading to tabulous 2.

The most significant change is to the syntax of app/tabs/tabulous.rb.

## New Syntax

Tabulous started out with a syntax where you specified tab behavior by adding Ruby code inside a grid of options.  This syntax was an experiment in code readability and communication, and provided a new way of thinking about how to interact with Ruby code.

There are three reasons this syntax was abandoned:

* Tabulous became popular enough that a syntax more in line with the typical conventions of Ruby and Rails programming would be more appropriate.
* A fair amount of newbies were using tabulous.  Experimental, boundary-pushing syntax is not appropriate for beginners as it may confuse their tastes in what constitutes good software design.
* Developers had mixed feelings about the syntax.  Some liked it, some hated it.  No one _loved_ it.

## Additions

* You can have more than one tab navigation bar on the same page.
* You can easily customize the generated tab markup.
* Namespaced controllers are now fully supported.
* You can now customize the HTTP verb of a tab link.

## Changes

* The active tab is now clickable by default.
* When tabulous cannot determine which tab to make active based on the controller action, the default behavior used to be to throw an error.  Now it is to not render the tabs.
* The default markup uses class="tabs" and class="subtabs" instead of id="tabs" and id="subtabs".
* The default markup no longer adds the classes "enabled" or "inactive" to tabs, as these are a bit redundant in the presence of "disabled" and "active" classes.
* Ruby 1.8 is no longer supported.

## Upgrading

Tabulous 1.3.2 was tested against Rails 4.0.0.beta, so is expected to work with Rails 4.  This means that if you are upgrading to Rails 4, you don't have to upgrade to tabulous 2.  However, keep in mind that the old tabulous syntax will not be supported for future versions of Rails.

To upgrade to tabulous 2, do the following:

* Make sure you're using Ruby 1.9 or later.
* You'll need to rewrite your tabulous.rb file according to the new syntax.
* Pay special attention to all the available settings in the customize block and their defaults, some of which have changed.
* After you've got tabulous 2 working, notice the tab HTML that's generated.  It's different enough that it can throw off any CSS or JavaScript you have related to this tab markup.  If it's causing you problems, you can either adjust your CSS and JavaScript, or tabulous lets you write your own tab HTML renderer to generate exactly the markup you desire.
