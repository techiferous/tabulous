module Tabulous

  class Tab
    
    attr_reader :name, :parent
    attr_accessor :subtabs
    
    def initialize(name, text, path, visible, enabled)
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
      if @text.is_a? Proc
        view.instance_eval(&@text)
      else
        @text
      end
    end
    
    def path(view)
      if @path.is_a? Proc
        view.instance_eval(&@path)
      else
        @path
      end
    end
    
    def visible?(view)
      if @visible.is_a? Proc
        !!view.instance_eval(&@visible)
      else
        !!@visible
      end
    end
    
    def enabled?(view)
      if @enabled.is_a? Proc
        !!view.instance_eval(&@enabled)
      else
        !!@enabled
      end
    end
    
  end

end
