Rails.application.routes.draw do
  devise_for :admins, controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :accounts, controllers: { sessions: "accounts/sessions", registrations: "accounts/registrations" }

  # Defines the root path route ("/")
  # root "articles#index"
end
