SampleApp::Application.routes.draw do

  resources :descuentos


  resources :reportes


  resources :retroaspectos


  resources :retroalimentacions


  resources :reservacions



  resources :niveles
  resources :tipomedallas
  resources :medallas
  
  #get "users/new"
  resources :clientes do
    member do
      get :profile, :muro
    end
  end

  resources :administradors


  resources :clientes



  #get "users/new"
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :reservacions, only: [:checkin]

  match '/listareportes', to: 'administradors#listareportes'
  match '/dashboard', to: 'clientes#dashboard'
  match '/reservaciones', to: 'clientes#reservaciones'
  match '/reporte', to: 'clientes#reporte'
  match '/retroalimentacion', to: 'clientes#retro'
  match '/checkin', to: 'reservacions#checkin'
  match '/recarga', to: 'pagos#recarga'
  match '/compra', to: 'pagos#compra'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  #get "static_pages#home"
  #get "static_pages#help"
  #get "static_pages#about"
  #get "static_pages#contact"

  root to: 'static_pages#home'

  match '/help', to: 'static_pages#help'
  match '/about', to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  match '/listadministradores', to: 'administradors#listadministradores'
  match '/administradors', to: 'administradors#index'


  match '/administrador_controller/jtable_list',   to: 'administradors#jtable_list',   via: [:get, :post]
  match '/administrador_controller/jtable_filterlist',   to: 'administradors#jtable_filterlist',   via: [:get, :post]
  match '/administrador_controller/jtable_create',   to: 'administradors#jtable_create',   via: [:get, :post]
  match '/administrador_controller/jtable_delete',   to: 'administradors#jtable_delete',   via: [:post]
  match '/administrador_controller/jtable_update',   to: 'administradors#jtable_update',   via: [:post]
  # match '/administradoresTableContainer/delete',   to: 'tables#administradoresTableContainer_delete',   via: [:post]

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
