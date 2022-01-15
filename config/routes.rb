Rails.application.routes.draw do
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'

  get 'calendar' => 'loans#calendar'
  resources :loans, only: %i(index show) do
    post :extend_loan, on: :member
    patch :set_returned, on: :member
    resource :extension, controller: 'loans/extensions', only: %i[create]
    resource :book_review, only: %i(create update)
  end
  resources :library_users, except: %i(show) do
    resource :activation, only: %i[create destroy], controller: 'library_users/activations'
  end

  root 'loans#index'
end
