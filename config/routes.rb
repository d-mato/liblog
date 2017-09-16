Rails.application.routes.draw do
  devise_for :users
  resources :loans
  resources :library_users

  root 'application#index'
end
