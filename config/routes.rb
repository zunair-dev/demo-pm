Rails.application.routes.draw do
  get 'admin/assign'
  get 'employees/index'
  get 'employees/pdf'
  get 'employees/complete'
  get 'users/new'
  get 'users/index'
  post 'employees/', to: 'users#create'
  resources :projects do
    resources :tasks do
      member do
        get 'assign'
      end
    end
  end
  namespace :project do
    resources :tasks do
      member do
        get 'assign'
      end
    end
  end
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "projects#index"
end
