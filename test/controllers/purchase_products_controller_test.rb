require 'test_helper'

class PurchaseProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase_product = purchase_products(:one)
  end

  test "should get index" do
    get purchase_products_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_product_url
    assert_response :success
  end

  test "should create purchase_product" do
    assert_difference('PurchaseProduct.count') do
      post purchase_products_url, params: { purchase_product: { product_id: @purchase_product.product_id, purchaseId: @purchase_product.purchaseId, quantity: @purchase_product.quantity, value: @purchase_product.value } }
    end

    assert_redirected_to purchase_product_url(PurchaseProduct.last)
  end

  test "should show purchase_product" do
    get purchase_product_url(@purchase_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_product_url(@purchase_product)
    assert_response :success
  end

  test "should update purchase_product" do
    patch purchase_product_url(@purchase_product), params: { purchase_product: { product_id: @purchase_product.product_id, purchaseId: @purchase_product.purchaseId, quantity: @purchase_product.quantity, value: @purchase_product.value } }
    assert_redirected_to purchase_product_url(@purchase_product)
  end

  test "should destroy purchase_product" do
    assert_difference('PurchaseProduct.count', -1) do
      delete purchase_product_url(@purchase_product)
    end

    assert_redirected_to purchase_products_url
  end
end
