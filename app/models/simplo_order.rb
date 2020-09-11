class SimploOrder < ApplicationRecord
  has_many :simplo_items

  def self.integrate_order_items
    @order_page = HTTParty.get("https://purchasestore.com.br/ws/wspedidos.json",
                                headers: { content: 'application/json',
                                Appkey: 'ZTgyYjMzZDJhMDVjMTVjZWM4OWNiMGU5NjI1NTNkYmU' })
    (1..@order_page['pagination']['page_count']).each do |i|
      @order_page = HTTParty.get("https://purchasestore.com.br/ws/wspedidos.json?page=#{i}",
                                 headers: { content: 'application/json',
                                            Appkey: 'ZTgyYjMzZDJhMDVjMTVjZWM4OWNiMGU5NjI1NTNkYmU' })
      @order_page['result'].each do |order_page|
        begin
          order = SimploOrder.find_by(order_id: order_page['Wspedido']['numero'])
          if order.nil?
            simplo_order = SimploOrder.create(client_name: order_page['Wspedido']['cliente_razaosocial'], 
                                              order_id: order_page['Wspedido']['numero'],
                                              order_status: order_page['Wspedido']['pedidostatus_id'],
                                              order_date: Time.parse(order_page['Wspedido']['data_pedido']))
            order_page['Item'].each do |item|
              product = Product.where(sku: item['sku']).or(Product.where(extra_sku: item['sku'])).first
              if product.present?
                SimploItem.create(sku: item['sku'], quantity: item['quantidade'].to_i, simplo_order_id: simplo_order.id, product_id: product.id)
              else
                SimploItem.create(sku: item['sku'], quantity: item['quantidade'].to_i, simplo_order_id: simplo_order.id)
              end
            end
          else
            order.update(order_status: order_page['Wspedido']['pedidostatus_id']) if order.order_status != order_page['Wspedido']['pedidostatus_id']
          end
        rescue ArgumentError
          puts 'erro'
        end
      end
    end
  end
end
