Rails.application.routes.draw do

  
  #get 'admin_users/index'

  #get 'admin_users/new'

  #get 'sessions/new'

  resources :users
  resources :searches
  resources :scorecards, only: [:create, :destroy]

  resources :questions do 
    resources :answers, only: [:create, :update, :destroy]
  end

  get    'home'    =>  'users#home'
  get    'data'    =>  'questions#index'
  get    'signup'  =>  'users#new'
  
  get    'login'   =>  'sessions#new'
  post   'login'   =>  'sessions#create'
  delete 'logout'  =>  'sessions#destroy'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  patch "/make_admin/:id" => "users#make_admin", as: :make_admin
  #get "users#index"

  root 'users#new' # "users#index" #WXU??? change this to User sign-in page
  
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
  #     resources :products
  #   end
end
