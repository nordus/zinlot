Zinlot::Application.routes.draw do
  resources :devices

  get "cars" => 'cars#index'
  get "live-inventory" => "live_location#index"
  get "map/index"
  get "devices" => "devices#index"
  get "vehicles" => 'vehicles#index'
  match "/netzke/:action(.:format)", to: 'netzke', as: 'netzke', via: :all
  get 'dashboard/index'
  get 'test-drives' => 'historical_trips#index'
  get 'test-drives/week' => 'historical_trips#week'
  get 'test-drives/:id' => 'historical_trips#show'
  get 'dtc-codes/:code' => 'dtc_codes#show'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :historical_trips, :only => [:create]
  resources :geofence_violations, :only => [:create]
  resources :alerts, :only => [:create]

  devise_for :admin_users, ActiveAdmin::Devise.config

  # You can have the root of your site routed with "root"
  root 'dashboard#index'
  ActiveAdmin.routes(self)

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
