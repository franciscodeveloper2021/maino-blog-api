Rails.application.routes.draw do
  resources :comments, only: [:index, :show, :new, :create, :update, :destroy]
  resources :users, only: [:create, :update] do
  end
  resources :posts, only: [:index, :show, :create, :update, :destroy]
  post 'login', to: 'users#log_in'
end
