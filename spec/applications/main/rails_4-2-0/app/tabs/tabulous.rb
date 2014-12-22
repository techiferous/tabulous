Tabulous.setup do

  tabs do
    home_tab do
      text          'Explanation'
      link_path     { root_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('home') }
    end

    galaxies_tab do
      text          'Galaxies'
      link_path     { galaxies_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies') }
    end

    stars_tab do
      text          'Stars'
      link_path     { stars_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('stars') }
    end

    planets_tab do
      text          'Planets'
      link_path     { planets_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('planets') }
    end

    subtabs_tab do
      text          'Subtabs'
      link_path     '/subtabs/one'
      visible_when  { true }
      enabled_when  { true }
      active_when   { a_subtab_is_active }
    end

    one_subtab do
      text          'One'
      link_path     '/subtabs/one'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('one').of_controller('subtabs') }
    end

    two_subtab do
      text          'Two'
      link_path     '/subtabs/two'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('two').of_controller('subtabs') }
    end

    three_subtab do
      text          'Three'
      link_path     '/subtabs/three'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('three').of_controller('subtabs') }
    end
  end

  use_css_scaffolding do
    background_color '#cec'
    text_color '#464'
    active_tab_color '#fff'
    hover_tab_color '#dfd'
    inactive_tab_color '#aca'
    inactive_text_color '#8a8'
  end

end
