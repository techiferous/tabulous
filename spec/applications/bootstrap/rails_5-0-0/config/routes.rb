Rails.application.routes.draw do
  get 'notabs' => 'no_tabs#index'
  root :to => 'home#index'
  get 'subtabs/one'

  get 'subtabs/two'

  get 'subtabs/three'

  get 'no_tabs/index'

  get 'home/index'

  resources :stars
  resources :planets
  resources :galaxies
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
