class SaleProduct < ApplicationRecord
  belongs_to :sale
  belongs_to :product
  scope :from_sale_store,  -> (store = "SemLoja") { includes(:sale).where(sales: { store_sale: store } )}
end
