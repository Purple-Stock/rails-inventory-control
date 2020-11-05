Rails.application.routes.draw do
  get '/info', to: 'companies#show'
  resources :purchase_products
  get 'purchase_products_defer', to: 'purchase_products#index_defer'
  get 'reports/daily_sale', to: 'reports#daily_sale'
  resources :purchases
  resources :suppliers
  resources :sales
  get 'sales_defer', to: 'sales#index_defer'
  get 'insert_orders', to: 'sales#insert_orders', as: 'insert_orders'
  post 'save_orders', to: 'sales#save_orders', as: 'save_orders'
  resources :sale_products
  resources :products
  get 'products_defer', to: 'products#index_defer'
  get 'products_tags_defer', to: 'products#tags_index_defer'
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
  get 'orders_products_stock', to: 'orders_control#show_orders_products_stock', as: 'show_orders_products_stock'
  get '/orders/post_mail_control', to: 'orders_control#post_mail_control', as: 'show_post_mail_control'
  post 'orders_control/import_post_mail' => 'orders_control#import_post_mail', as: 'import_post_mail'
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'products/:custom_id', to: 'products#show', as: 'show'
      get 'products', to: 'products#index', as: 'index'
      post 'purchase_products/add_products', to: 'purchase_products#add_products', as: 'add_products'
      post 'purchase_products/add_inventory_quantity', to: 'purchase_products#add_inventory_quantity', as: 'add_inventory_quantity'
    end
  end
  root to: 'products#index'
end