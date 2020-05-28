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
  get 'group_lists', to: 'groups#show_group_product', as: 'show_group_product'
  get 'confection_lists', to: 'groups#show_product_confection', as: 'show_product_confection'
  root to: 'sales#index'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'products/:custom_id', to: 'products#show', as: 'show'
      post 'purchase_products/add_products', to: 'purchase_products#add_products', as: 'add_products'
    end
  end
  get 'products_defer', to: "products#index_defer"
end