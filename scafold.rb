rails generate scaffold User name:string last_name:string email:string password:string
rails generate scaffold Company name:string trade:string cnpj:string user_id:integer
rails generate scaffold Category name:string company_id:integer
rails generate scaffold Customer name:string email:string cellphone:string company_id:integer
rails generate scaffold Product name:string price:float code:string imageUrl:string highlight:boolean category_id:integer company_id:integer
rails generate scaffold Supplier name:string cnpj:string email:string cellphone:string address:string city:string state:string landmark:string note:string company_id:integer
rails generate scaffold Purchase value:float supplier_id:integer company_id:integer
rails generate scaffold PurchaseItem quantity:integer product_id:integer purchaseId:integer
rails generate scaffold SaleItem quantity:integer product_id:integer saleId:integer
rails generate scaffold Sale value:float discount:float percentage:float online:boolean disclosure:boolean customer_id:integer company_id:integer
