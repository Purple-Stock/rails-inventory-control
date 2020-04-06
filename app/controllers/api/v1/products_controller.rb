module Api
  module V1
		class ProductsController < ActionController::Base
			def show
				@product = Product.find_by(custom_id: params[:custom_id])
			end
		end
	end
end
