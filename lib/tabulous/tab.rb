module Tabulous
  class Tab

    attr_reader :parent
    attr_accessor :subtabs, :kind, :name, :declared_to_have_subtabs
    attr_writer :text, :link_path, :visible_when, :enabled_when, :http_verb

    def initialize
      @subtabs = []
      @active_actions = {}
      @kind = :primary_tab
      @declared_to_have_subtabs = false
      @http_verb = :get
    end

    def parent=(tab)
      raise "only subtabs can have parents" unless subtab?
      @parent = tab
      @parent.subtabs = @parent.subtabs + [self]
    end

    def subtab?
      @kind == :subtab
    end

    def text(view=nil)
      value = if @text.respond_to?(:call)
        view.instance_exec(&@text)
      else
        @text
      end
      unless value.is_a?(String)
        raise ImproperValueError, "The text of tab '#{self.name}' needs to be a string."
      end
      value
    end

    def link_path(view=nil)
      value = if @link_path.respond_to?(:call)
        view.instance_exec(&@link_path)
      else
        @link_path
      end
      unless value.is_a?(String)
        raise ImproperValueError, "The link_path of tab '#{self.name}' needs to be a string."
      end
      value
    end

    def http_verb(view=nil)
      value = if @http_verb.respond_to?(:call)
        view.instance_exec(&@http_verb)
      else
        @http_verb
      end
      value = value.to_s.downcase.to_sym
      unless [:get, :post, :delete, :patch, :put].include?(value)
        raise ImproperValueError, "The http_verb of tab '#{self.name}' must be :get, :post, :delete, :patch or :put."
      end
      value
    end

    def visible?(view=nil)
      if @visible_when.respond_to?(:call)
        view.instance_exec(&@visible_when)
      else
        @visible_when
      end
    end

    def enabled?(view=nil)
      if @enabled_when.respond_to?(:call)
        view.instance_exec(&@enabled_when)
      else
        @enabled_when
      end
    end

    def clickable?(view)
      enabled?(view) && (!active?(view) || Config.active_tab_clickable)
    end

    # controller actions that make this tab active
    def add_active_actions(controller, actions)
      controller = controller.to_s
      actions = [actions] if !actions.is_a?(Array)
      for action in actions
        @active_actions[controller] ||= []
        @active_actions[controller] << action.to_s
      end
    end

    def active?(view)
      current_controller = view.controller_path.to_s
      current_action = view.action_name.to_s
      active_actions = @active_actions[current_controller]
      return true if active_actions && (active_actions.include?('any') || active_actions.include?(current_action))
      return true if @subtabs.any? { |subtab| subtab.active?(view) }
      false
    end

    def active_actions_overlap?(tab)
      for controller in @active_actions.keys
        other_actions = tab.active_actions[controller]
        if other_actions
          these_actions = @active_actions[controller]
          if (!(other_actions & these_actions).empty?) ||
             other_actions.include?('any') ||
             these_actions.include?('any')
            return true
          end
        end
      end
      false
    end

  protected

    def active_actions
      @active_actions
    end

  end
end
