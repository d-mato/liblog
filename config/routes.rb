Rails.application.routes.draw do
  devise_for :users
  resources :loans, only: %i(index show) do
    resource :book_review, only: %i(create update)
  end
  resources :library_users

  get '/' => redirect('/loans')
end
