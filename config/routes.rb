Rails.application.routes.draw do
  get '/info', to: 'companies#show'
  resources :purchase_products
  resources :purchases
  resources :suppliers
  resources :sales
  resources :sale_products
  resources :products
  resources :customers
  resources :categories
  resources :groups
  resources :group_products
  get 'companies/new'
  post 'companies/create'
  devise_for :users
  root to: 'sales#index'
end