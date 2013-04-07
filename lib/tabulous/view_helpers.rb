module Tabulous
  module ViewHelpers

    def tabs(tabset_name = :default)
      RenderingCoordinator.new(Tabsets.get(tabset_name), self).render_tabs
    end

    def subtabs(tabset_name = :default)
      RenderingCoordinator.new(Tabsets.get(tabset_name), self).render_subtabs
    end

  end
end
