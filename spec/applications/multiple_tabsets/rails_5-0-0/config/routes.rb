Rails.application.routes.draw do
  root :to => 'home#index'
  get 'home/index'

  namespace :planets do
    resources :rogue_planets
  end
  namespace :planets do
    resources :exoplanets
  end
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
