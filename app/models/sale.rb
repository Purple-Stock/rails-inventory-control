class Sale < ApplicationRecord
  belongs_to :customer
  has_many :sale_products, inverse_of: :sale, dependent: :destroy 
  accepts_nested_attributes_for :sale_products, reject_if: :all_blank, allow_destroy: true
  enum payment_type: [:Débito, :Crédito, :Dinheiro]
end
