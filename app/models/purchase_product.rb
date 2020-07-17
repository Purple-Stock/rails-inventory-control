class PurchaseProduct < ApplicationRecord
  belongs_to :purchase, optional: true
  belongs_to :product
  enum store_entrance: %i[Sem_Loja PurchaseStoreRS PurchaseStoreSP]
end
