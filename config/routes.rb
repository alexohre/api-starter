Rails.application.routes.draw do
  get 'admin_details', to: 'admins#index'
  get 'account_details', to: 'accounts#index'
  get 'user_details', to: 'users#index'

  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: "admins/registrations", confirmations: "admins/confirmations", passwords: "admins/passwords" }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", confirmations: "users/confirmations", passwords: "users/passwords" }
  devise_for :accounts, controllers: { sessions: "accounts/sessions", registrations: "accounts/registrations", confirmations: "accounts/confirmations", passwords: "accounts/passwords" }


  # Defines the root path route ("/")
  # root "articles#index"
end
