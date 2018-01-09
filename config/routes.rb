Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users
  root to: "users#dashboard"

  resources :leave_applications, only: [:create, :index]
  get '/leave_applications/approval' => 'leave_applications#approval'
end
