Rails.application.routes.draw do
  get 'admin/assign'
  get 'employees/index'
  get 'employees/pdf'
  get 'employees/complete'
  get 'employees/tasks'
  get 'employees/projects'
  get 'employees/active_projects'
  get 'employees/completed_projects'
  get 'users/new'
  get 'users/index'
  post 'employees/', to: 'users#create'
  resources :projects do
    collection do
      get 'all'
    end
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
