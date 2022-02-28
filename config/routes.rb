Rails.application.routes.draw do
  resources :todos do
    get '/items', to: 'items#show'
    put '/items', to: 'items#update'
    delete '/items', to: 'items#destroy'
    post '/items', to: 'items#create'
  end
  post 'signup', to: 'auth#signup'
  post 'auth/login'
    
end
