module Tabulous
  module TestData

    class DummyViewContext
      def controller_path
        'breads'
      end
      def action_name
        'spoonbread'
      end
    end

    def create_sample_tabset
      @view = DummyViewContext.new
      @tabset = Tabulous::Tabset.new

      @cakes_tab = Tabulous::Tab.new
      @cakes_tab.name = 'cakes'
      @cakes_tab.text = 'cakes'
      @cakes_tab.link_path = '/cakes'
      @cakes_tab.visible_when = true
      @cakes_tab.enabled_when = true
      @cakes_tab.add_active_actions('cakes', 'any')
      @tabset.add_tab(@cakes_tab)

      @cookies_tab = Tabulous::Tab.new
      @cookies_tab.name = 'cookies'
      @cookies_tab.text = 'cookies'
      @cookies_tab.link_path = '/cookies'
      @cookies_tab.visible_when = false
      @cookies_tab.enabled_when = true
      @cookies_tab.add_active_actions('cookies', 'any')
      @tabset.add_tab(@cookies_tab)

      @cupcakes_tab = Tabulous::Tab.new
      @cupcakes_tab.name = 'cupcakes'
      @cupcakes_tab.text = 'cupcakes'
      @cupcakes_tab.link_path = '/cupcakes'
      @cupcakes_tab.visible_when = true
      @cupcakes_tab.enabled_when = false
      @cupcakes_tab.add_active_actions('cupcakes', 'any')
      @tabset.add_tab(@cupcakes_tab)

      @breads_tab = Tabulous::Tab.new
      @breads_tab.name = 'breads'
      @breads_tab.text = 'breads'
      @breads_tab.link_path = '/breads'
      @breads_tab.http_verb = :delete
      @breads_tab.visible_when = true
      @breads_tab.enabled_when = true
      @tabset.add_tab(@breads_tab)

      @spoonbread_tab = Tabulous::Tab.new
      @spoonbread_tab.name = 'spoonbread'
      @spoonbread_tab.kind = :subtab
      @spoonbread_tab.parent = @breads_tab
      @spoonbread_tab.text = 'spoonbread'
      @spoonbread_tab.link_path = '/breads/spoonbread'
      @spoonbread_tab.visible_when = true
      @spoonbread_tab.enabled_when = true
      @spoonbread_tab.add_active_actions('breads', 'spoonbread')
      @tabset.add_tab(@spoonbread_tab)

      @banana_bread_tab = Tabulous::Tab.new
      @banana_bread_tab.name = 'banana bread'
      @banana_bread_tab.kind = :subtab
      @banana_bread_tab.parent = @breads_tab
      @banana_bread_tab.text = 'banana bread'
      @banana_bread_tab.link_path = '/breads/banana-bread'
      @banana_bread_tab.http_verb = :post
      @banana_bread_tab.visible_when = true
      @banana_bread_tab.enabled_when = true
      @banana_bread_tab.add_active_actions('breads', 'banana_bread')
      @tabset.add_tab(@banana_bread_tab)
    end

  end
end
