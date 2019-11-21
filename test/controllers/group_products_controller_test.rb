require 'test_helper'

class GroupProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_product = group_products(:one)
  end

  test "should get index" do
    get group_products_url
    assert_response :success
  end

  test "should get new" do
    get new_group_product_url
    assert_response :success
  end

  test "should create group_product" do
    assert_difference('GroupProduct.count') do
      post group_products_url, params: { group_product: {  } }
    end

    assert_redirected_to group_product_url(GroupProduct.last)
  end

  test "should show group_product" do
    get group_product_url(@group_product)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_product_url(@group_product)
    assert_response :success
  end

  test "should update group_product" do
    patch group_product_url(@group_product), params: { group_product: {  } }
    assert_redirected_to group_product_url(@group_product)
  end

  test "should destroy group_product" do
    assert_difference('GroupProduct.count', -1) do
      delete group_product_url(@group_product)
    end

    assert_redirected_to group_products_url
  end
end
