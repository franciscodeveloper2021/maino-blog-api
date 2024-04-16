Rails.application.routes.draw do
  resources :users, only: [:create, :update] do
    post 'update_password', to: 'users#update_password'
  end
  post '/login', to: 'users#log_in'
end
