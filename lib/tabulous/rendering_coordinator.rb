# The RenderingCoordinator gets called from the tabs or subtabs helper
# in the view and delegates to a renderer object, which produces the
# appropriate HTML.
#
# The RenderingCoordinator picks the appropriate rendering class to use
# based on the renderer named in the Tabulous setup file.
#
# The RenderingCoordinator is not responsible for generating any HTML itself,
# but is responsible for the algorithm of how the HTML gets generated.
# For example, it adds CSS scaffolding if needed, and behaves according to
# the value of the when_action_has_no_tab setting in the Tabulous setup file.
#
# This keeps renderer classes from having to focus on the behavior of rendering
# as specified in the Tabulous setup file and instead renderer classes can
# focus on producing HTML.

module Tabulous
  class RenderingCoordinator

    def initialize(tabset, view)
      @view = view
      @tabset = tabset
      begin
        @renderer = "Tabulous::#{Config.renderer.to_s.camelize}Renderer".constantize.new(tabset, view)
      rescue NameError
        @renderer = "#{Config.renderer.to_s.camelize}Renderer".constantize.new(tabset, view)
      end
    end

    def render_tabs
      return if check_for_active_tab == :do_not_render
      html = ''
      html << CssScaffolding.embeddable_styles if Config.use_css_scaffolding
      html << @renderer.tabs_html
      @view.raw(html)
    end

    def render_subtabs
      return if check_for_active_tab == :do_not_render
      return '' if @tabset.visible_subtabs(@view).empty? && !Config.render_subtabs_when_empty
      html = ''
      html << @renderer.subtabs_html
      @view.raw(html)
    end

  private

    def check_for_active_tab
      if !@tabset.active_primary_tab(@view)
        if Config.when_action_has_no_tab == :raise_error
          msg = "No tab is defined for the action '#{@view.action_name}' in the controller '#{@view.controller_path}'."
          msg << " One of your tabs should have a valid active_when declaration that hooks it up to this controller action."
          raise NoTabFoundError, msg
        else
          return Config.when_action_has_no_tab
        end
      end
    end

  end
end
