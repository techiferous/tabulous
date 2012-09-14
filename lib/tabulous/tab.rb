module Tabulous

  class Tab
    
    attr_reader :name, :parent
    attr_accessor :subtabs
    
    def initialize(name, text, path, visible, enabled, options)
      @name = name
      name = name.to_s
      if name.ends_with? '_tab'
        @kind = :tab
      elsif name.ends_with? '_subtab'
        @kind = :subtab
      else
        raise TabNameError,
              "Incorrect tab name: '#{name}'.  Tab names must end with _tab or _subtab."
      end
      @text = text
      @path = path
      @visible = visible
      @enabled = enabled
      @options = options || {}
      @subtabs = []
    end
    
    def add_parent(tab)
      @parent = tab
      @parent.subtabs = @parent.subtabs + [self]
    end
    
    def subtab?
      @kind == :subtab
    end
    
    def text(view)
      @text
    end
    
    def path(view)
      @path
    end
    
    def visible?(view)
      !!@visible
    end
    
    def enabled?(view)
      !!@enabled
    end

    def options(view)
      @options
    end

  end

end
