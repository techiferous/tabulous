require 'ostruct'

module Tabulous
  module Dsl
    class Tab
      class << self

        def process(name, parent_tab, &block)
          @tab = ::Tabulous::Tab.new
          @tab.name = name.to_s
          if parent_tab
            @tab.kind = :subtab
            @tab.parent = parent_tab
          end
          @called = []
          instance_exec(&block)
          check_for_errors!
          @tab
        end

        def text(val = nil, &block)
          @called << :text
          @tab.text = block_given? ? block : val
        end

        def link_path(val = nil, &block)
          @called << :link_path
          @tab.link_path = block_given? ? block : val
        end

        def http_verb(val = nil, &block)
          @called << :http_verb
          @tab.http_verb = block_given? ? block : val
        end

        def visible_when(val = nil, &block)
          @called << :visible_when
          @tab.visible_when = block_given? ? block : val
        end

        def enabled_when(val = nil, &block)
          @called << :enabled_when
          @tab.enabled_when = block_given? ? block : val
        end

        def active_when(&block)
          @called << :active_when
          instance_exec(&block)
        end

        def a_subtab_is_active
          @tab.declared_to_have_subtabs = true
        end

        def in_actions(*actions)
          @active_mediator = OpenStruct.new
          @active_mediator.this = self
          @active_mediator.actions = actions
          def @active_mediator.of_controller(controller)
            self.controller = controller
            self.this.send(:register_rule)
          end
          @active_mediator
        end

        def in_action(action)
          in_actions(action)
        end

        def method_missing(method, *args, &block)
          raise UnknownDeclarationError, "Unknown declaration '#{method}'."
        end

      private

        def check_for_errors!
          [:text, :link_path, :visible_when, :enabled_when, :active_when].each do |advice|
            if !@called.include?(advice)
              raise MissingDeclarationError, "Missing '#{advice}' in tab #{@tab.name}."
            end
          end
        end

        def register_rule
          @tab.add_active_actions(@active_mediator.controller, @active_mediator.actions)
        end

      end
    end
  end
end
