Rails.application.routes.draw do

  get 'new_comer'=> 'new_comer#index'
  get 'complain'=> 'complains#index'



  get 'teach/queen'=>'teach#queen'
  get 'teach/owner'=>'teach#owner'
  get 'teach/introduce'=>'teach#introduce'
  get 'teach/custom_list'=>'teach#custom_list'
  get 'teach/rule_center'=>'teach#rule_center'
  get 'teach/trading_process'=>'teach#trading_process'
  


  post 'complain'=> 'complains#create'

  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :attachments
  resources :search_dropdown, only: [:index]
  resources :tasks do
    member do
      get 'confirm'
      get 'refuse'
      get :send_message
    end

    resources :attachments
  end

  resources :plans
  resources :users do
    member do
      get 'dashboard'
      get 'mread'
      get 'following_list'
      get 'voteable_list'
      get 'verify'
      get 'choose'
      get 'project_list'
      get 'product_list'
    end
    resource :profile
  end

  resources :queen_works do
    member do
      get 'follow_it'
      get 'vote_it'
    end

    resources :attachments
  end

  resources :queens do
    member do
      get 'dashboard'
    end
  end

  resources :products

  resources :needs do
    resources :tasks
    resources :plans
    resources :need_imgs, only: [:create, :destroy]

    member do
      get 'waitfor_upload'=> 'needs#wait_upload'
      get 'upload_file'
      get 'file_list'
      get 'waitfor'
      get 'plan_confirm'
      get 'plan_refuse'
      get 'complete'
      post 'create_comment'
      put  'update_comment'
      get 'destroy_comment'
      get 'convert_to_queen_work'
    end
  end
  resources :uploads

  get 'needs/need_params'



  devise_for :admin_users, ActiveAdmin::Devise.config

  ActiveAdmin.routes(self)

  root 'welcome#index'
  get     'login'   => 'sessions#new'
  post    'login'   => 'sessions#create'
  delete  'logout'  => 'sessions#destroy'
  get     'signup'  => 'users#new'
  get     'bind_wx'  => 'users#bind_wx'
  get     '/auth/wechat'  => 'sessions#wechat'
  get '/auth/wechat/callback'=> 'sessions#auth_callback'

  namespace :api, defaults: {format: :json} do
    resources :banners

    resources :needs do
      member do
        post :vote_to_me
        get :vote_sum
      end
    end

    resources :queens do
      get :search, on: :collection
      get :following_list, on: :collection
    end

    resources :queen_works do
      get :search, on: :collection
      resources :attachments
    end

    resources :needs do
      resources :tasks
      resources :plans
      get 'convert_to_queen_work'
    end
    resources :tasks do
      resources :attachments
      member do
        get :confirm
        get :confuse

      end
    end
    resources :plans

  end
  # get     'queen_login'   => 'queen_sessions#new'
  # post    'queen_login'   => 'queen_seconvert
  # ssions#create'
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
