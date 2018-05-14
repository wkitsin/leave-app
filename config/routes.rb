Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  root to: "users#dashboard"
  resources :calenders, only: [:index]
  resources :leave_applications, except: [:show]
  resources :approval, only: [:create]
end
