Rails.application.routes.draw do
  get '/info', to: 'companies#show'
  resources :purchase_products
  get 'purchase_products_defer', to: 'purchase_products#index_defer'
  resources :purchases
  resources :suppliers
  resources :sales
  get 'sales_defer', to: 'sales#index_defer'
  resources :sale_products
  resources :products
  get 'products_defer', to: 'products#index_defer'
  get '/products/:id/duplicate', to: 'products#duplicate', as: 'meeting_duplicate'
  resources :customers
  resources :categories
  resources :groups
  resources :group_products
  get 'companies/new'
  post 'companies/create'
  devise_for :users
  get 'group_lists', to: 'groups#show_group_product', as: 'show_group_product'
  get 'confection_lists', to: 'groups#show_product_confection', as: 'show_product_confection'
  get 'orders_control', to: 'orders_control#show_orders_control', as: 'show_orders_control'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'products/:custom_id', to: 'products#show', as: 'show'
      post 'purchase_products/add_products', to: 'purchase_products#add_products', as: 'add_products'
    end
  end
  root to: 'sales#index'
end