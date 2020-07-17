require 'rqrcode_png'

class Product < ApplicationRecord
  belongs_to :category
  has_many :purchase_products
  has_many :sale_products
  has_many :group_products
  has_one_attached :image

  def count_purchase_product
    rs = 0
    sp = 0
    h = 0
    self.purchase_products.each do |pp|
      if pp.store_entrance == 'PurchaseStoreRS'
        rs += pp.quantity
      elsif pp.store_entrance == 'PurchaseStoreSP'
        sp += pp.quantity
      else
        h += pp.quantity
      end
    end
    "RS: #{rs}  SP: #{sp}"
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
    rs = 0
    sp = 0
    h = 0
    self.sale_products.each do |pp|
      if pp.sale.store_sale == 'PurchaseStoreRS'
        rs += pp.quantity
      elsif pp.sale.store_sale == 'PurchaseStoreSP'
        sp += pp.quantity
      else
        h += pp.quantity
      end
    end
    "RS: #{rs}  SP: #{sp}"
  end

  def balance
    rs = 0
    sp = 0
    h = 0
    self.purchase_products.each do |pp|
      if pp.store_entrance == 'PurchaseStoreRS'
        rs += pp.quantity
      elsif pp.store_entrance == 'PurchaseStoreSP'
        sp += pp.quantity
      else
        h += pp.quantity
      end
    end
    self.sale_products.each do |pp|
      if pp.sale.store_sale == 'PurchaseStoreRS'
        rs -= pp.quantity
      elsif pp.sale.store_sale == 'PurchaseStoreSP'
        sp -= pp.quantity
      else
        h -= pp.quantity
      end
    end
    "RS: #{rs}  SP: #{sp}"
  end

  def self.generate_qrcode(url)
    obj = { id: url.id, custom_id: url.custom_id, name: url.name, price: url.price }
    RQRCode::QRCode.new(obj.to_json)
  end

end
