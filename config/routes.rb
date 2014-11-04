SampleApp::Application.routes.draw do


  resources :conductors

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


  resources :rutas
  resources :paradas

  resources :vans



  #get "users/new"
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :viajes do
    member do
      get :detalle
    end
  end

  resources :reservacions do
    member do
      get :retroalimentacion
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :retroalimentacion, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :reservacions, only: [:checkin]

  match '/listareportes', to: 'administradors#listareportes'
  match '/retroalimentaciones', to: 'administradors#reporteretros'
  
  match '/inicio', to: 'administradors#inicio'
  match '/dashboard', to: 'clientes#dashboard'
  match '/buscar', to: 'clientes#buscarviaje'
  match '/reservaciones', to: 'clientes#reservaciones'
  match '/reporte', to: 'clientes#reporte'
  match '/retro', to: 'reservacions#create_retro'
  match '/retro', to: 'reservacions#retro'
  match '/checkin', to: 'reservacions#checkin'

  match '/formapago', to: 'clientes#formapago'
  match '/compracredito', to: 'clientes#compracredito'

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

  match '/administrar_administradores', to: 'administradors#administradores', via:[:get, :post, :put]
  match '/administrar_administrador_detalle', to: 'administradors#administrador_detalleadministrador', via:[:get, :post, :put]
  match '/administrador_controller/jtable_list',   to: 'administradors#jtable_list',   via: [:get, :post]
  match '/administrador_controller/jtable_filterlist',   to: 'administradors#jtable_filterlist',   via: [:get, :post]
  match '/administrador_controller/jtable_create',   to: 'administradors#jtable_create',   via: [:get, :post]
  match '/administrador_controller/jtable_delete',   to: 'administradors#jtable_delete',   via: [:post]
  match '/administrador_controller/jtable_update',   to: 'administradors#jtable_update',   via: [:post]
  # match '/administradoresTableContainer/delete',   to: 'tables#administradoresTableContainer_delete',   via: [:post]

  match '/administrador_controller/update',   to: 'administradors#update',   via: [:post,:put]
  match '/administrador_controller/create',   to: 'administradors#create',   via: [:post,:put]


  match '/administrar_conductores', to: 'administradors#conductores', via:[:get, :post, :put]
  match '/conductor_controller/jtable_list',   to: 'conductors#jtable_list',   via: [:post, :get]
  match '/conductor_controller/jtable_filterlist',   to: 'conductors#jtable_filterlist',   via: [:get, :post]
  match '/conductor_controller/jtable_create',   to: 'conductors#jtable_create',   via: [:get, :post]
  match '/conductor_controller/jtable_delete',   to: 'conductors#jtable_delete',   via: [:post]
  match '/conductor_controller/jtable_update',   to: 'conductors#jtable_update',   via: [:post]
  match '/conductor_controller/update',   to: 'conductors#update',   via: [:post,:put]
  match '/conductor_controller/create',   to: 'conductors#create',   via: [:post,:put]



  match '/van_controller/jtable_list',   to: 'vans#jtable_list',   via: [:get, :post]
  match '/van_controller/jtable_filterlist',   to: 'vans#jtable_filterlist',   via: [:get, :post]
  match '/van_controller/jtable_create',   to: 'vans#jtable_create',   via: [:get, :post]
  match '/van_controller/jtable_delete',   to: 'vans#jtable_delete',   via: [:post]
  match '/van_controller/jtable_update',   to: 'vans#jtable_update',   via: [:post]
  match '/van_controller/update',   to: 'vans#update',   via: [:post,:put]

  match '/administrar_van_detalle',   to: 'administradors#administrador_detallevan',   via: [:get, :post, :put]

  match '/ruta_controller/jtable_list',   to: 'rutas#jtable_list',   via: [:get, :post, :put]
  match '/ruta_controller/jtable_filterlist',   to: 'rutas#jtable_filterlist',   via: [:get, :post]
  match '/ruta_controller/jtable_delete',   to: 'rutas#jtable_delete',   via: [:post]
  match '/rutas/:id', to: 'rutas#show', via: [ :get]
  match '/rutas/:id', to: 'rutas#actualizar', via: [:post, :put]

  match '/administrar_ruta_detalle',   to: 'rutas#administrador_detalleruta',   via: [:get, :post, :put]
  match '/administrar_clientes', to: 'administradors#clientes', via:[:get, :post, :put]
  # match '/administrador_perfilcliente', to: 'administradors#administrador_perfilcliente', via:[:get]
  match '/administrar_cliente_detalle', to: 'administradors#administrador_detallecliente', via:[:get, :post, :put]
  match '/cliente_controller/jtable_list',   to: 'clientes#jtable_list',   via: [:post, :get]
  match '/cliente_controller/jtable_filterlist',   to: 'clientes#jtable_filterlist',   via: [:get, :post]
  # match '/cliente_controller/jtable_create',   to: 'clientes#jtable_create',   via: [:get, :post]
  match '/cliente_controller/jtable_delete',   to: 'clientes#jtable_delete',   via: [:post]
  match '/cliente_controller/jtable_update',   to: 'clientes#jtable_update',   via: [:post]
  match '/cliente_controller/update',   to: 'clientes#update',   via: [:post,:put]
  match '/cliente_controller/create',   to: 'clientes#create',   via: [:post,:put]

  match '/sugerencias', to: 'administradors#sugerencias', via:[:get, :post, :put]
  match '/sugerencia_controller/jtable_list',   to: 'sugerencias#jtable_list',   via: [:post, :get]
  match '/sugerencia_controller/jtable_filterlist',   to: 'sugerencias#jtable_filterlist',   via: [:get, :post]
  match '/administrar_sugerencia_detalle',   to: 'administradors#administrador_detallesugerencia',   via: [:get, :post, :put]


  match '/procesar_busqueda',   to: 'clientes#procesarbusquedaviaje',   via: [:get, :post]

  match '/administrar_medallas', to: 'administradors#medallas', via:[:get, :post, :put]
  match '/medalla_controller/jtable_list',   to: 'medallas#jtable_list',   via: [:post, :get]
  match '/medalla_controller/jtable_filterlist',   to: 'medallas#jtable_filterlist',   via: [:get, :post]
  match '/medalla_controller/jtable_create',   to: 'medallas#jtable_create',   via: [:get, :post]
  match '/medalla_controller/jtable_delete',   to: 'medallas#jtable_delete',   via: [:post]
  match '/medalla_controller/jtable_update',   to: 'medallas#jtable_update',   via: [:post]
  match '/medalla_controller/update',   to: 'medallas#update',   via: [:post,:put]
  match '/medalla_controller/create',   to: 'medallas#create',   via: [:post,:put]

  match '/administrar_medalla_detalle',   to: 'administradors#administrador_detallemedalla',   via: [:get, :post, :put]

  match '/show_viajes', to: 'administradors#show_viajes', via:[:get, :post, :put]

  match '/registrar_subida',   to: 'conductors#registrar_subida',   via: [:post,:get]

  match '/buscar_zona', to:'clientes#buscar_viaje_zona'
  match '/resultado_zona', to: 'rutas#listar_por_zona', via: [:get, :post]

  match '/viaje_controller/proximos_jtable_filterlist',   to: 'viajes#proximos_jtable_filterlist',   via: [:get, :post]
  match '/viaje_controller/realizados_jtable_filterlist',   to: 'viajes#realizados_jtable_filterlist',   via: [:get, :post]
  match '/administrador_detalleviaje',   to: 'administradors#administrador_detalleviaje',   via: [:get, :post, :put]

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
