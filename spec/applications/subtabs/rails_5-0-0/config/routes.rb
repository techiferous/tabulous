Rails.application.routes.draw do
  get 'disabled/always_disabled' => 'misc#always_disabled'
  get 'disabled/always_enabled' => 'misc#always_enabled'
  get 'hidden/always_hidden' => 'misc#always_hidden'
  get 'hidden/always_visible' => 'misc#always_visible'
  root :to => 'home#index'
  get 'misc/always_hidden'

  get 'misc/always_visible'

  get 'misc/always_enabled'

  get 'misc/always_disabled'

  get 'home/index'

  resources :stars
  resources :rogue_planets
  resources :exoplanets
  namespace :galaxies do
    resources :spiral_galaxies
  end
  namespace :galaxies do
    resources :lenticular_galaxies
  end
  namespace :galaxies do
    resources :elliptical_galaxies
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
