class PurchaseProductsController < ApplicationController
  before_action :set_purchase_product, only: [:show, :edit, :update, :destroy]

  # GET /purchase_products
  # GET /purchase_products.json
  def index
    @purchase_products = PurchaseProduct.last 500
  end

  # GET /purchase_products/1
  # GET /purchase_products/1.json
  def show
  end

  # GET /purchase_products/new
  def new
    @purchase_product = PurchaseProduct.new
  end

  # GET /purchase_products/1/edit
  def edit
  end

  # POST /purchase_products
  # POST /purchase_products.json
  def create
    @purchase_product = PurchaseProduct.new(purchase_product_params)

    respond_to do |format|
      if @purchase_product.save
        format.html { redirect_to @purchase_product, notice: 'Entrada de estoque criado.' }
        format.json { render :show, status: :created, location: @purchase_product }
      else
        format.html { render :new }
        format.json { render json: @purchase_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchase_products/1
  # PATCH/PUT /purchase_products/1.json
  def update
    respond_to do |format|
      if @purchase_product.update(purchase_product_params)
        format.html { redirect_to @purchase_product, notice: 'Entrada de estoque alterado.' }
        format.json { render :show, status: :ok, location: @purchase_product }
      else
        format.html { render :edit }
        format.json { render json: @purchase_product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchase_products/1
  # DELETE /purchase_products/1.json
  def destroy
    @purchase_product.destroy
    respond_to do |format|
      format.html { redirect_to purchase_products_url, notice: 'Entrada de estoque deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase_product
      @purchase_product = PurchaseProduct.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_product_params
      params.require(:purchase_product).permit(:quantity, :value, :product_id, :purchaseId)
    end
end
