Rails.application.routes.draw do
  get 'admin_details', to: 'admins#index'
  get 'account_details', to: 'accounts#index'
  get 'user_details', to: 'users#index'

  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :accounts, controllers: { sessions: "accounts/sessions", registrations: "accounts/registrations" }

  # Defines the root path route ("/")
  # root "articles#index"
end
