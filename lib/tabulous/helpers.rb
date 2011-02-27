module Tabulous
  module Helpers
    
    def tabs
      Tabulous.render_tabs(self)
    end

    def subtabs
      Tabulous.render_subtabs(self)
    end

  end
end
