Hinagiku::Application.routes.draw do
  root :to => "tasks#index"
  
  resources :tasks do
    put :finish, :restart, :on => :member
    get :done, :search, :on => :collection
  end
  
  resources :categories do
    resources :tasks, :only => [ :index ] do
      get :done, :on => :collection 
    end
  end
  
  resource :session, :only => [ :new, :create, :destroy ]
  resource :account, :except => [ :edit ]
  resource :password, :only => [ :edit, :update ] do
    get :updated
  end
  
  match '*anything' => 'errors#not_found'
end
