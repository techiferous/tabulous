require 'capybara/rails'

module ActionController
  class IntegrationTest

    include Capybara

    def assert_tab_not_present(text)
      begin
        message = "expected tab with text '#{text}' to not be present"
        page.find(:xpath, %Q{//div[@id="tabs"]//ul/li/*[. = "#{text}"]})
        assert_block(message) { false }
      rescue Capybara::ElementNotFound:
        assert_block(message) { true }
      end
    end

    def assert_tab_present(text)
      begin
        message = "expected tab with text '#{text}' to be present"
        page.find(:xpath, %Q{//div[@id="tabs"]//ul/li/*[. = "#{text}"]})
        assert_block(message) { true }
      rescue Capybara::ElementNotFound:
        assert_block(message) { false }
      end
    end

    def assert_subtab_not_present(text)
      begin
        message = "expected subtab with text '#{text}' to not be present"
        page.find(:xpath, %Q{//div[@id="subtabs"]//ul/li/*[. = "#{text}"]})
        assert_block(message) { false }
      rescue Capybara::ElementNotFound:
        assert_block(message) { true }
      end
    end

    def assert_subtab_present(text)
      begin
        message = "expected subtab with text '#{text}' to be present"
        page.find(:xpath, %Q{//div[@id="subtabs"]//ul/li/*[. = "#{text}"]})
        assert_block(message) { true }
      rescue Capybara::ElementNotFound:
        assert_block(message) { false }
      end
    end

    def assert_tab_disabled(text)
      message = "expected tab with text '#{text}' to be disabled"
      result = page.all('#tabs li.disabled', :text => text)
      assert_block(message) { !result.empty? }
    end

    def assert_tab_enabled(text)
      message = "expected tab with text '#{text}' to be enabled"
      result = page.all('#tabs li.enabled', :text => text)
      assert_block(message) { !result.empty? }
    end

    def assert_subtab_disabled(text)
      message = "expected subtab with text '#{text}' to be disabled"
      result = page.all('#subtabs li.disabled', :text => text)
      assert_block(message) { !result.empty? }
    end

    def assert_subtab_enabled(text)
      message = "expected subtab with text '#{text}' to be enabled"
      result = page.all('#subtabs li.enabled', :text => text)
      assert_block(message) { !result.empty? }
    end

    def assert_tab_active(text)
      message = "expected tab with text '#{text}' to be active"
      result = page.all('#tabs li.active', :text => text)
      assert_block(message) { !result.empty? }
    end

    def assert_subtab_active(text)
      message = "expected subtab with text '#{text}' to be active"
      result = page.all('#subtabs li.active', :text => text)
      assert_block(message) { !result.empty? }
    end

    def use_initializer(i)
      eval i
    end

  end
end
