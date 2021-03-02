Rails.application.routes.draw do
  get 'csv_files/new'
  get 'csv_files/show'
  get 'csv_files/index'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
