class Product < ApplicationRecord
  belongs_to :category
  has_many :purchase_products
  has_many :sale_products
  has_many :group_products
  has_one_attached :image

  def count_purchase_product
    sum = 0
    self.purchase_products.each do |pp|
      sum += pp.quantity
    end
    sum
  end

  def count_sale_product
    sum = 0
    self.sale_products.each do |pp|
      sum += pp.quantity
    end
    sum
  end

end
