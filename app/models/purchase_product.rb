class PurchaseProduct < ApplicationRecord
  belongs_to :purchase, optional: true
end
