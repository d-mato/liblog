Rails.application.routes.draw do
  devise_for :users
  get 'calendar' => 'loans#calendar'
  resources :loans, only: %i(index show) do
    post :extend_loan, on: :member
    patch :set_returned, on: :member
    resource :extension, only: %i[create]
    resource :book_review, only: %i(create update)
  end
  resources :library_users, except: %i(show) do
    member do
      patch :activate
      delete :activate
    end
  end

  root 'loans#index'
end
