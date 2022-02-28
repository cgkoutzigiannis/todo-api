Rails.application.routes.draw do
  resources :todos
  post 'signup', to: 'auth#signup'
  post 'auth/login'
end
