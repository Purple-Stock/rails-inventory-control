class OrdersControlController < ApplicationController
	def show_orders_control
		@send_orders = []
		list_orders
		@orders.each_with_index do |order, index|
			if order[index]["Wspedido"]["pedidostatus_id"] != '24' && order[index]["Wspedido"]["pedidostatus_id"] != '1' && order[index]["Wspedido"]["pedidostatus_id"] != '4'
				@send_orders << order[index]
			end
		end
		@send_orders
	end

	private 

	def list_orders
		@orders = []
		for i in 1..5
	  	@order_page = HTTParty.get("https://purchasestore.com.br/ws/wspedidos.json?page=#{i}",
	         										headers: { content: 'application/json',
	                    				Appkey: 'ZTgyYjMzZDJhMDVjMTVjZWM4OWNiMGU5NjI1NTNkYmU' })
	  	@orders << @order_page['result']
	  end
  end

end
