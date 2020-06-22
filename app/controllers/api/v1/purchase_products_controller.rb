class Api::V1::PurchaseProductsController < ActionController::Base
	skip_before_action :verify_authenticity_token
	before_action :set_products, only: %i[add_products]
	
	def add_products
		save_succeeded = true
		@target_records = []
		@products.each do |product|
			purchase_product = PurchaseProduct.new(product_id: product[:product_id], quantity: product[:quantity])
			save_succeeded = false unless purchase_product.save
			@target_records << purchase_product
		end
		if save_succeeded
			render json: { status: 'success', message: 'Saved Purchase Product', data: @target_records }, status: :ok
		else
			render json: { status: 'error', message: 'Purchase Product not saved', data: @target_records }, status: :unprocessable_entity
		end
	end

	private
	 
	def set_products
  	@products = params.require(:products)
	end
end
