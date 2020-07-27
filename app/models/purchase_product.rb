class PurchaseProduct < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :product
  enum store_entrance: %i[Sem_Loja PurchaseStoreRS PurchaseStoreSP]
  scope :from_store, -> (store = self.store_entrances["Sem_Loja"]) {where("store_entrance = ?", self.store_entrances[store])}
end
