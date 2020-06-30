# frozen_string_literal: true

class OrdersControlController < ApplicationController
  def show_orders_control
    @send_orders = []
    # list_orders
    unique_order
    @orders.each do |order|
      # if order['Wspedido']['pedidostatus_id'] == '23' || order['Wspedido']['pedidostatus_id'] == '3'
        @send_orders << order
      # end
    end
    @send_orders
  end

  def post_mail_control
    @post_data = PostDatum.all
  end

  def import_post_mail
    params[:files].each do |file|
      doc = Nokogiri::HTML(open(file))
      doc.remove_namespaces!
      date = doc.css('dt')[4].text.split(' ')
      date = Time.parse("#{date[1]} #{date[3]}")
      data_position = { client_name: 17, cep: 18, state: 19, post_code: 24, value: 27 }
      post_type = 'PAC'
      if PostDatum.where(post_code: doc.css('table td')[data_position[:post_code]].text).empty?
        PostDatum.create(client_name: doc.css('table td')[data_position[:client_name]].text.capitalize,
                         cep: doc.css('table td')[data_position[:cep]].text,
                         state: doc.css('table td')[data_position[:state]].text,
                         post_code: doc.css('table td')[data_position[:post_code]].text,
                         value: doc.css('table td')[data_position[:value]].text.gsub(',', '.').to_f,
                         send_date: date,
                         post_type: post_type)
        (1..doc.css('table td').count/9).each do |i|

          if doc.css('table td')[data_position[:client_name]+12].text.to_f == 0.0
            PostDatum.create(client_name: doc.css('table td')[data_position[:client_name]+= 12].text.capitalize,
                             cep: doc.css('table td')[data_position[:cep]+= 12].text,
                             state: doc.css('table td')[data_position[:state]+= 12].text,
                             post_code: doc.css('table td')[data_position[:post_code]+= 12].text,
                             value: doc.css('table td')[data_position[:value]+= 12].text.gsub(',', '.').to_f,
                             send_date: date,
                             post_type: post_type)
          else
            PostDatum.create(client_name: doc.css('table td')[data_position[:client_name]+= 17].text.capitalize,
                             cep: doc.css('table td')[data_position[:cep]+= 17].text,
                             state: doc.css('table td')[data_position[:state]+= 17].text,
                             post_code: doc.css('table td')[data_position[:post_code]+= 17].text,
                             value: doc.css('table td')[data_position[:value]+= 17].text.gsub(',', '.').to_f,
                             send_date: date,
                             post_type: post_type = 'SEDEX')
          end
        end
      end
    end
    redirect_to show_post_mail_control_path, notice: 'Dados inseridos com sucesso!'
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
