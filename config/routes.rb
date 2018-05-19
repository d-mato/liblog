Rails.application.routes.draw do
  root 'loans#index'
  devise_for :users
  get 'calendar' => 'loans#calendar'
  resources :loans, only: %i(index show) do
    resource :book_review, only: %i(create update)
  end
  resources :library_users, except: %i(show) do
    member do
      patch :activate
      delete :activate
    end
  end

  ActiveAdmin.routes(self)
end
