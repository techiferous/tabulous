module Tabulous
  module Dsl
    class Setup
      class << self

        def process(&block)
          instance_exec(OldVersionChecker.new, &block)
        end

        def customize(&block)
          Dsl::Config.process(&block)
        end

        def use_css_scaffolding(&block)
          ::Tabulous::Config.use_css_scaffolding = true
          Dsl::Config.process(&block) if block_given?
        end

        def tabs(tabset_name = :default, &block)
          tabset = Dsl::Tabs.process(&block)
          Tabsets.add(tabset_name, tabset)
        end

        def method_missing(method, *args, &block)
          raise UnknownDeclarationError, "Unknown declaration '#{method}'. Valid declarations here are tabs, customize, and use_css_scaffolding."
        end

      end
    end
  end
end
