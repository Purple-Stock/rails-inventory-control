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

  def count_month_purchase_product(year, month)
    first_day_month = Time.new(year, month.to_i, 1)
    last_day_month = first_day_month.end_of_month
    sum = 0
    self.purchase_products.where(created_at: first_day_month..last_day_month).each do |pp|
      sum += pp.quantity
    end
    sum
  end

  def count_month_sale_product(year, month)
    first_day_month = Time.new(year, month.to_i, 1)
    last_day_month = first_day_month.end_of_month
    sum = 0
    self.sale_products.where(created_at: first_day_month..last_day_month).each do |pp|
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
