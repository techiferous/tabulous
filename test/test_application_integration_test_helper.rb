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
      begin
        message = "expected tab with text '#{text}' to be disabled"
        # would be better to check for the disabled class but don't know how to do that
        page.find(:xpath, %Q{//div[@id="tabs"]//ul/li/span[. = "#{text}"]})
        assert_block(message) { false }
      rescue Capybara::ElementNotFound:
        assert_block(message) { true }
      end
    end

    def assert_tab_enabled(text)
      begin
        message = "expected tab with text '#{text}' to be enabled"
        # would be better to check for the disabled class but don't know how to do that
        page.find(:xpath, %Q{//div[@id="tabs"]//ul/li/span[. = "#{text}"]})
        assert_block(message) { true }
      rescue Capybara::ElementNotFound:
        assert_block(message) { false }
      end
    end

  end
end
