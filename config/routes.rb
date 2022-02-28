Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  resources :todos 
  get 'todos/:id/items', to: 'items#show'
  put 'todos/:id/items', to: 'items#update'
  delete 'todos/:id/items', to: 'items#destroy'
  post 'todos/:id/items', to: 'items#create'
  
  post 'signup', to: 'auth#signup'
  post 'auth/login'
    
end
