Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :csv_files, except: [:edit, :update] do
    resources :query, only: :create
  end
  resources :query, except: [:new, :create]
end
