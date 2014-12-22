### 2.1.2 (Dec 22, 2014)
* Added support for Rails 4.2 and Ruby 2.2.

### 2.1.1 (May 28, 2014)
* Added support for Rails 4.1 and Ruby 2.1.

### 2.1.0 (Nov 9, 2013)
* Added http_verb tab declaration to support non-GET actions, like sign out links.
* Added renderer that generates HTML compatible with Bootstrap 3's navbar.
* Documentation tweaks.
* Added better float-clearing styles in CSS scaffolding.

### 2.0.0 (May 12, 2013)
* Introduced a completely new, non-backwards-compatible syntax for app/tabs/tabulous.rb.
* You can have more than one tab navigation bar on the same page.
* You can customize the generated tab markup by creating your own renderer class.
* Namespaced controllers are now fully supported.
* The active tab is now clickable by default.
* When tabulous cannot determine which tab to make active based on the controller action, the
  default behavior used to be to throw an error.  Now it is to not render the tabs.
* The default markup uses class="tabs" and class="subtabs" instead of id="tabs" and id="subtabs".
* The default markup no longer adds the classes "enabled" or "inactive" to tabs, as these are a bit
  redundant in the presence of "disabled" and "active" classes.
* Ruby 1.8 is no longer supported.

### 1.3.2 (April 12, 2013)
* Fixed a bug where the gem's gemspec did not include all of the files.

### 1.3.1 (April 6, 2013)
* Ensured compatibility with Rails 4.0.0.beta1 and Ruby 2.0.
* Maintained compatibility with Rails 3.0, 3.1 and 3.2 and Ruby 1.8 and 1.9.
* Complete overhaul of the test applications to make them easier to test across multiple versions of
  Rails and Ruby.

### 1.3.0 (March 20, 2012)
* Added config.subtabs_ul_class.
* Verified that tabulous works with Ruby 1.9.3.

### 1.2.0 (February 8, 2012)
* Added support for Twitter Bootstrap (version 2).
* Noted in the documentation that tabulous works with Rails 3.2.

### 1.1.0 (January 10, 2012)
* Deprecated the raise_error_if_no_tab_found configuration setting.  Replaced it with
  config.when_action_has_no_tab.
* Changed some gem versions in the development dependencies.

### 1.0.3 (November 6, 2011)
* Added support for Rails 3.1 (finally!).

### 1.0.2 (April 19, 2011)
* Fixed bug where the tabs generator would crash if there were index routes that were not named.

### 1.0.1 (March 9, 2011)
* No longer requires Rubygems version > 1.4.0; requires > 1.3.7 instead.

### 1.0.0 (March 4, 2011)
* Moved tab file from config/initializers/tabulous.rb to app/tabs/tabulous.rb.
* Changed syntax so that config.tabs and config.actions accepts a block.

### 0.0.2 (March 2, 2011)
* Changed homepage in gemspec.

### 0.0.1 (March 2, 2011)
* Initial release.
