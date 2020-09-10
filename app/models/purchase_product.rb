class PurchaseProduct < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :product
  enum store_entrance: %i[Sem_Loja PurchaseStoreRS PurchaseStoreSP]
  scope :from_store, -> (store = self.store_entrances["Sem_Loja"]) {where("store_entrance = ?", self.store_entrances[store])}

  DATATABLE_COLUMNS = %w[custom_id name].freeze

  class << self
    def filter_products(purchased_products, search_value)
      return all if search_value.blank?

      result = none
      DATATABLE_COLUMNS.each do |column|
        filter = purchased_products.where("products.#{column} ILIKE ? ", "%#{search_value}%")
        result = result.or(filter)
      end
      result
    end

    def datatable_order(order_column_index, order_dir)
      order_column_index = 1 if order_column_index == 4
      order("products.#{PurchaseProduct::DATATABLE_COLUMNS[order_column_index]} #{order_dir}")
    end
  end


end
