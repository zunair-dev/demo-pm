Rails.application.routes.draw do
  get 'admin/assign'
  resources :employees, only: [:index] do
    collection do
      get 'pdf', to: "employees#pdf"
      get 'complete', to: "employees#complete"
      get 'tasks', to: "employees#tasks"
      get 'projects', to: "employees#projects"
      get 'active_projects', to: "employees#active_projects"
      get 'completed_projects', to: "employees#completed_projects"
    end
  end
  # get 'employees/index'
  # get 'employees/pdf'
  # get 'employees/complete'
  # get 'employees/tasks'
  # get 'employees/projects'
  # get 'employees/active_projects'
  # get 'employees/completed_projects'
  devise_for :users
  resources :users, except: [:create] do
    collection do
      get 'admins', to: 'users#admins'
    end
    member do
      get 'profile', to: 'users#profile'
    end
  end
  post 'new_user/', to: 'users#create'
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "projects#index"
end
