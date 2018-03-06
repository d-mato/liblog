Rails.application.routes.draw do
  devise_for :users
  resources :loans
  resources :library_users

  get '/' => redirect('/loans')
end
