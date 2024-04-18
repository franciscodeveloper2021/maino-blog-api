Rails.application.routes.draw do
  resources :users, only: [:create, :update] do
  end
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  post '/login', to: 'users#log_in'

  root 'posts#index'
end
