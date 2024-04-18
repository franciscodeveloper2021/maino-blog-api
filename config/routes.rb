Rails.application.routes.draw do
  resources :users, only: [:create, :update] do
  end
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  root '/login', to: 'users#log_in'

  root 'users#welcome'
end
