class SalesController < ApplicationController
  before_action :set_sale, only: [:show, :edit, :update, :destroy]

  # GET /sales
  # GET /sales.json
  def index; end

  def index_defer
    @sales = Sale.includes(:sale_products)
    render json: SaleSerializer.new(@sales).serialized_json
  end

  # GET /sales/1
  # GET /sales/1.json
  def show; end

  # GET /sales/new
  def new
    @sale = Sale.new
    @sale_products = @sale.sale_products.build
  end

  # GET /sales/1/edit
  def edit; end

  # POST /sales
  # POST /sales.json
  def create
    @sale = Sale.new(sale_params)
    calc_value
    respond_to do |format|
      if @sale.save
        format.html { redirect_to @sale, notice: 'Venda Criada.' }
        format.json { render :show, status: :created, location: @sale }
      else
        format.html { render :new }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sales/1
  # PATCH/PUT /sales/1.json
  def update
    respond_to do |format|
      if @sale.update(sale_params)
        calc_value
        format.html { redirect_to @sale, notice: 'Venda Alterada.' }
        format.json { render :show, status: :ok, location: @sale }
      else
        format.html { render :edit }
        format.json { render json: @sale.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sales/1
  # DELETE /sales/1.json
  def destroy
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Venda deletada.' }
      format.json { head :no_content }
    end
  end

  def insert_orders; end

  def save_orders
    number_orders = params[:number_orders].delete(' ').split(",")
    number_orders.each do |no|
      Sale.integrate_orders(no, params[:sale][:origin])
    end
    respond_to do |format|
      format.html { redirect_to sales_url, notice: 'Venda Integrada com sucesso.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sale
      @sale = Sale.find(params[:id])
    end

    def calc_value
      value = 0
      @sale.sale_products.each do |sale_product|
        value += sale_product.value * sale_product.quantity
      end
      value -= @sale.discount if @sale.discount.present?
      @sale.update(value: value)
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def sale_params
      params.require(:sale).permit(:value, :exchange, :discount, :percentage, :online, :created_at, :disclosure, :customer_id,
                                   :payment_type, :store_sale, :total_exchange_value,
                                   sale_products_attributes: [:id, :product_id, :quantity, :value, :_destroy])
    end
end
