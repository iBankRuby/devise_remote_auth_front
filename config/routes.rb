Rails.application.routes.draw do
  root to: 'home#index'

  post 'users/sign_in', to: 'sessions#create'
  delete 'users/log_out', to: 'sessions#destroy'
  get 'users/sign_in', to: 'sessions#new'
end
