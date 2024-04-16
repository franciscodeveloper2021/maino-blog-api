Rails.application.routes.draw do
  resources :users, only: [:create, :update]
  post '/login', to: 'users#log_in'
end
