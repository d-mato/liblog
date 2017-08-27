Rails.application.routes.draw do
  devise_for :users
  resources :loans

  root 'application#index'
end
