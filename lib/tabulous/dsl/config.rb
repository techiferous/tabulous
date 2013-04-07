module Tabulous
  module Dsl
    class Config
      class << self

        def process(&block)
          instance_exec(&block)
        end

        def method_missing(method, *args, &block)
          ::Tabulous::Config.send("#{method}=", *args)
        end

      end
    end
  end
end
