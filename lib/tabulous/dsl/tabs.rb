module Tabulous
  module Dsl
    class Tabs
      class << self

        def process(&block)
          @tabset = Tabset.new
          @parent_tab = nil
          instance_exec(&block)
          check_for_errors!
          @tabset
        end

        def method_missing(method, *args, &block)
          method_name = method.to_s
          if method_name =~ /^(.+)_subtab/
            if @parent_tab.nil?
              raise SubtabOutOfOrderError, "You cannot start a tabs declaration with a subtab: '#{method_name}'."
            end
            tab = Dsl::Tab.process($1, @parent_tab, &block)
          elsif method_name =~ /^(.+)_tab/
            tab = Dsl::Tab.process($1, nil, &block)
            @parent_tab = tab
          else
            raise TabNameError, "Incorrect tab name: '#{method_name}'.  Tab names must end with _tab or _subtab."
          end
          @tabset.add_tab(tab)
        end

      private

        def check_for_errors!
          check_for_missing_subtab_declaration
          check_for_conflicting_active_actions
        end

        def check_for_missing_subtab_declaration
          for tab in @tabset.primary_tabs
            if !tab.subtabs.empty? && tab.declared_to_have_subtabs == false
              raise MissingActiveTabRuleError, "The tab '#{tab.name}' has subtabs but is missing the 'a_subtab_is_active' rule in its active_when declaration."
            end
          end
        end

        def check_for_conflicting_active_actions
          for tab in @tabset.tabs
            for other_tab in @tabset.tabs
              next if tab == other_tab
              if tab.active_actions_overlap?(other_tab)
                raise AmbiguousActiveTabRulesError, "Ambiguous declaration: the active_when rules in the tab #{tab.name} conflict with the active_when rules in the tab #{other_tab.name}."
              end
            end
          end
        end

      end
    end
  end
end
