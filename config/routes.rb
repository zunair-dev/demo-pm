Rails.application.routes.draw do
  get 'employees/index'
  get 'users/new'
  post 'employees',  to: 'users#add_user'
  resources :projects do
    resources :tasks
  end
  namespace :project do
    resources :tasks
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "projects#index"
end
