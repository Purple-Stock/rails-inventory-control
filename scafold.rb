rails generate scaffold User name:string last_name:string email:string password:string 
rails g model Company name description:text subdomain cnpj:string cpf:string


rails generate scaffold Category name:string 
rails generate scaffold Customer name:string email:string cellphone:string phone:string cpf
rails generate scaffold Product name:string price:float bar_code:string image_url:string highlight:boolean category_id:integer active:boolean

rails generate scaffold Sale value:float discount:float percentage:float online:boolean disclosure:boolean customer_id:integer 
rails generate scaffold SaleProduct quantity:integer value:float product_id:integer saleId:integer

rails generate scaffold Supplier name:string cnpj:string email:string cellphone:string phone:string address:string city:string state:string landmark:string note:string 
rails generate scaffold Purchase value:float supplier_id:integer 
rails generate scaffold PurchaseProduct quantity:integer value:float product_id:integer purchaseId:integer
