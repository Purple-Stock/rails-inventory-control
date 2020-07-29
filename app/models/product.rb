require 'rqrcode_png'

class Product < ApplicationRecord
  belongs_to :category
  has_many :purchase_products
  has_many :sale_products
  has_many :group_products
  has_one_attached :image

  def count_purchase_product
    rs = self.purchase_products.from_store("PurchaseStoreRS").sum("Quantity")
    sp = self.purchase_products.from_store("PurchaseStoreSP").sum("Quantity")
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
    rs ||= self.sale_products.from_sale_store("PurchaseStoreRS").sum("Quantity")
    sp ||= self.sale_products.from_sale_store("PurchaseStoreSP").sum("Quantity")
    "RS: #{rs}  SP: #{sp}"
  end

  def balance
    rs = self.purchase_products.from_store("PurchaseStoreRS").sum("Quantity")
    sp = self.purchase_products.from_store("PurchaseStoreSP").sum("Quantity")
    rs -= self.sale_products.from_sale_store("PurchaseStoreRS").sum("Quantity")
    sp -= self.sale_products.from_sale_store("PurchaseStoreSP").sum("Quantity")
    "RS: #{rs}  SP: #{sp}"
  end

  def self.generate_qrcode(url)
    obj = { id: url.id, custom_id: url.custom_id, name: url.name, price: url.price }
    RQRCode::QRCode.new(obj.to_json)
  end

  DATATABLE_COLUMNS = %w[custom_id name].freeze

  class << self
    def datatable_filter(search_value, search_columns)
      return all if search_value.blank?

      result = none
      search_columns.each do |key, value|
        filter = where("#{DATATABLE_COLUMNS[key.to_i]} ILIKE ?", "%#{search_value}%")
        result = result.or(filter) if value['searchable']
      end
      result
    end

    def datatable_order(order_column_index, order_dir)
      order_column_index = 1 if order_column_index == 4
      order("#{Product::DATATABLE_COLUMNS[order_column_index]} #{order_dir}")
    end
  end
end
