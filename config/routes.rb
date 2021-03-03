Rails.application.routes.draw do
  get 'filters/edit'
  get 'filters/new'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :csv_files, except: [:edit, :update] do
    resources :queries, except: :delete
  end
  resources :queries, only: :delete do
    resources :filters, only: :create
  end
  resources :filters, except: [:create, :new]
end
