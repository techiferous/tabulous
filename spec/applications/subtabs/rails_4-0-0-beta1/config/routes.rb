Rails400Beta1::Application.routes.draw do
  get 'disabled/always_disabled' => 'misc#always_disabled'
  get 'disabled/always_enabled' => 'misc#always_enabled'
  get 'hidden/always_hidden' => 'misc#always_hidden'
  get 'hidden/always_visible' => 'misc#always_visible'
  root :to => 'home#index'
  get "misc/always_hidden"
  get "misc/always_visible"
  get "misc/always_enabled"
  get "misc/always_disabled"
  get "home/index"
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

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root to: 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
