Tabulous.setup do

  tabs do

    home_tab do
      text          { 'Home' }
      link_path     { home_index_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('home') }
    end

    stars_tab do
      text          { 'Stars' }
      link_path     { stars_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('stars') }
    end

    planets_tab do
      text          { 'Planets' }
      link_path     { planets_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('planets') }
    end

    galaxies_tab do
      text          { 'Galaxies' }
      link_path     { galaxies_path }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies') }
    end

  end

  use_css_scaffolding

end
