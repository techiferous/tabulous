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
      link_path     '/galaxies/elliptical_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { a_subtab_is_active }
    end

    elliptical_galaxies_subtab do
      text          'Elliptical Galaxies'
      link_path     '/galaxies/elliptical_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/elliptical_galaxies') }
    end

    spiral_galaxies_subtab do
      text          'Spiral Galaxies'
      link_path     '/galaxies/spiral_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/spiral_galaxies') }
    end

    lenticular_galaxies_subtab do
      text          'Lenticular Galaxies'
      link_path     '/galaxies/lenticular_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/lenticular_galaxies') }
    end

    planets_tab do
      text          'Planets'
      link_path     '/exoplanets'
      visible_when  { true }
      enabled_when  { true }
      active_when   { a_subtab_is_active }
    end

    exoplanets_subtab do
      text          'Exoplanets'
      link_path     { exoplanets_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('exoplanets') }
    end

    rogue_planets_subtab do
      text          'Rogue Planets'
      link_path     { rogue_planets_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('rogue_planets') }
    end

    stars_tab do
      text          { request.path =~ /stars/ ? 'Stars!' : 'Stars' }
      link_path     { stars_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('stars') }
    end

    hidden_tab do
      text          'Hidden'
      link_path     '/hidden/always_visible'
      visible_when  { request.path =~ /(hidden|galaxies)/ }
      enabled_when  { true }
      active_when   { a_subtab_is_active }
    end

    always_visible_subtab do
      text          'Always Visible'
      link_path     '/hidden/always_visible'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('always_visible').of_controller('misc') }
    end

    always_hidden_subtab do
      text          'Always Hidden'
      link_path     '/hidden/always_hidden'
      visible_when  false
      enabled_when  { true }
      active_when   { in_action('always_hidden').of_controller('misc') }
    end

    disabled_tab do
      text          'Disabled'
      link_path     '/disabled/always_enabled'
      visible_when  { true }
      enabled_when  { request.path =~ /(disabled|stars)/ }
      active_when   { a_subtab_is_active }
    end

    always_enabled_subtab do
      text          'Always Enabled'
      link_path     '/disabled/always_enabled'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('always_enabled').of_controller('misc') }
    end

    always_disabled_subtab do
      text          'Always Disabled'
      link_path     '/disabled/always_disabled'
      visible_when  { true }
      enabled_when  false
      active_when   { in_action('always_disabled').of_controller('misc') }
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
