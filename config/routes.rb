Rails.application.routes.draw do
  resources :users, only: [:create, :update] do
  end
  resources :posts
  post '/login', to: 'users#log_in'
end
