Tabulous.setup do

  tabs(:galaxies) do
    elliptical_galaxies_tab do
      text          'Elliptical Galaxies'
      link_path     '/galaxies/elliptical_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/elliptical_galaxies') }
    end

    spiral_galaxies_tab do
      text          'Spiral Galaxies'
      link_path     '/galaxies/spiral_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/spiral_galaxies') }
    end

    lenticular_galaxies_tab do
      text          'Lenticular Galaxies'
      link_path     '/galaxies/lenticular_galaxies'
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('galaxies/lenticular_galaxies') }
    end
  end

  tabs(:planets) do
    exoplanets_tab do
      text          'Exoplanets'
      link_path     { '/planets/exoplanets' }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('planets/exoplanets') }
    end

    rogue_planets_tab do
      text          'Rogue Planets'
      link_path     { '/planets/rogue_planets' }
      visible_when  { true }
      enabled_when  { true }
      active_when   { in_action('any').of_controller('planets/rogue_planets') }
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
