rails generate scaffold User name:string last_name:string email:string password:string 
rails g model Company name description:text subdomain cnpj:string cpf:string


rails generate scaffold Store name:string cnpj:string cpf:string
rails generate model StoreUser store_id:integer user_id:integer

rails generate scaffold Category name:string store_id:integer
rails generate scaffold Customer name:string email:string cellphone:string phone:string store_id:integer
rails generate scaffold Product name:string price:float bar_code:string image_url:string highlight:boolean category_id:integer store_id:integer active:boolean
rails generate scaffold Supplier name:string cnpj:string email:string cellphone:string phone:string address:string city:string state:string landmark:string note:string store_id:integer
rails generate scaffold Purchase value:float supplier_id:integer store_id:integer
rails generate scaffold PurchaseItem quantity:integer product_id:integer purchaseId:integer
rails generate scaffold SaleItem quantity:integer product_id:integer saleId:integer
rails generate scaffold Sale value:float discount:float percentage:float online:boolean disclosure:boolean customer_id:integer store_id:integer
