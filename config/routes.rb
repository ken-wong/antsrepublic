Rails.application.routes.draw do
  
  resources :tasks
  resources :users do
    member do
      get 'dashboard'
      get 'following_list'
      get 'voteable_list'
      get 'verify'
      get 'choose'
      get 'project_list'
    end
    resource :profile
  end



  resources :queens do
    member do
      get 'dashboard'
    end
  end
  
  resources :products
  resources :needs 
  resources :uploads  

  get 'needs/index'

  get 'needs/show'

  get 'needs/update'

  get 'needs/create'

  get 'needs/desttroy'

  get 'needs/need_params'


  devise_for :admin_users, ActiveAdmin::Devise.config
  
  ActiveAdmin.routes(self)
  
  root 'welcome#index'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
  get     'signup'  => 'users#new'
  # get     'queen_login'   => 'queen_sessions#new'
  # post    'queen_login'   => 'queen_sessions#create'
  # delete  'queen_logout'  => 'queen_sessions#destroy'
  # get     'queen_signup'  => 'queens#new'
  # get     'choose'  => 'welcome#choose'
  # get     'choose_login' => 'welcome#choose_login'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     #   end
end
