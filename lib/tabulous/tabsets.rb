module Tabulous
  class Tabsets

    class << self

      def add(tabset_name, tabset)
        @tabsets ||= {}
        @tabsets[tabset_name.to_s] = tabset
      end

      def get(tabset_name)
        @tabsets[tabset_name.to_s]
      end

    end

  end
end
