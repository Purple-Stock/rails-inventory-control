class PurchaseProductSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :quantity

  attribute :name do |object|
    object.product.name
  end  

  attribute :custom_id do |object|
    object.product.custom_id
  end

  attribute :value do |object|
    "R$#{object.value.to_s.gsub('.', ',')}"
  end  

  attribute :image_url do |object|
    object.product.image_url
  end  

  attribute :created_at do |object|
    object.created_at.strftime("%-d/%-m/%Y %H:%M")
  end

end
