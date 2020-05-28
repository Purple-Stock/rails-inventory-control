class ProductSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :custom_id, :name,:count_purchase_product, :count_sale_product, :active, :image_url

  attribute :price do |object|
    "R$ #{object.price}"
  end

  attribute :balance do |object|
    object.count_purchase_product - object.count_sale_product
  end

  attribute :category do |object|
    object.category.name
  end

  attribute :active do |object|
    if object.active
      'Sim'
    else
      'Não'
    end
  end

end