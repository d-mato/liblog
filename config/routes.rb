Rails.application.routes.draw do
  root 'loans#index'
  devise_for :users
  resources :loans, only: %i(index show) do
    resource :book_review, only: %i(create update)
  end
  resources :library_users, except: %i(show)

  ActiveAdmin.routes(self)
end
