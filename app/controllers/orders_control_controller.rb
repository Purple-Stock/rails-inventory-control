# frozen_string_literal: true

class OrdersControlController < ApplicationController
  def show_orders_control
    @send_orders = []
    list_orders
    @orders.each do |order|
      if order['Wspedido']['pedidostatus_id'] != '24' && order['Wspedido']['pedidostatus_id'] != '1' && order['Wspedido']['pedidostatus_id'] != '4'
        @send_orders << order
      end
    end
    @send_orders
  end

  private

  def list_orders
    @orders = []
    (1..5).each do |i|
      @order_page = HTTParty.get("https://purchasestore.com.br/ws/wspedidos.json?page=#{i}",
                                 headers: { content: 'application/json',
                                            Appkey: 'ZTgyYjMzZDJhMDVjMTVjZWM4OWNiMGU5NjI1NTNkYmU' })
      @order_page['result'].each do |order_page|
        @orders << order_page
      end
    end
  end
end
