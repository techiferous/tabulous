RSpec::Matchers.define :be_clickable do
  match do |tab_text|
    clickable_tab = page.all('.tabs li a', :text => tab_text)
    clickable_subtab = page.all('.subtabs li a', :text => tab_text)
    !clickable_tab.empty? || !clickable_subtab.empty?
  end

  failure_message do |actual|
    "expected that a tab or subtab with the text '#{tab_text}' would be clickable"
  end

  failure_message_for_should_not do |actual|
    "expected that a tab or subtab with the text '#{tab_text}' would not be clickable"
  end
end
