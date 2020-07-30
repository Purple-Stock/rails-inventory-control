class PurchaseProduct < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :product
  enum store_entrance: %i[Sem_Loja PurchaseStoreRS PurchaseStoreSP]
  scope :from_store, -> (store = self.store_entrances["Sem_Loja"]) {where("store_entrance = ?", self.store_entrances[store])}

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
