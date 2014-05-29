module TabHelpers

  def use_tab_file(i)
    eval i
  end

  def visible_tabs
    page.all('.tabs li', :visible => true).map(&:text)
  end

  def visible_subtabs
    page.all('.subtabs li', :visible => true).map(&:text)
  end

  def disabled_tabs
    page.all('.tabs li.disabled', :visible => true).map(&:text)
  end

  def disabled_subtabs
    page.all('.subtabs li.disabled', :visible => true).map(&:text)
  end

  def enabled_tabs
    page.all('.tabs li:not(.disabled)', :visible => true).map(&:text)
  end

  def enabled_subtabs
    page.all('.subtabs li:not(.disabled)', :visible => true).map(&:text)
  end

  def active_tab
    active_tabs = page.all('.tabs li.active', :visible => true)
    raise "more than one active tab" if active_tabs.count > 1
    active_tabs.first.text
  end

  def active_subtab
    active_subtabs = page.all('.subtabs li.active', :visible => true)
    raise "more than one active subtab" if active_subtabs.count > 1
    active_subtabs.first.text
  end

  def subtabs_should_be_present
    page.all('.subtabs', :visible => false).should_not be_empty
  end

  def subtabs_should_not_be_present
    page.all('.subtabs', :visible => false).should be_empty
  end

end
