require "application_system_test_case"

class PurchaseProductsTest < ApplicationSystemTestCase
  setup do
    @purchase_product = purchase_products(:one)
  end

  test "visiting the index" do
    visit purchase_products_url
    assert_selector "h1", text: "Purchase Products"
  end

  test "creating a Purchase product" do
    visit purchase_products_url
    click_on "New Purchase Product"

    fill_in "Product", with: @purchase_product.product_id
    fill_in "Purchaseid", with: @purchase_product.purchaseId
    fill_in "Quantity", with: @purchase_product.quantity
    fill_in "Value", with: @purchase_product.value
    click_on "Create Purchase product"

    assert_text "Purchase product was successfully created"
    click_on "Back"
  end

  test "updating a Purchase product" do
    visit purchase_products_url
    click_on "Edit", match: :first

    fill_in "Product", with: @purchase_product.product_id
    fill_in "Purchaseid", with: @purchase_product.purchaseId
    fill_in "Quantity", with: @purchase_product.quantity
    fill_in "Value", with: @purchase_product.value
    click_on "Update Purchase product"

    assert_text "Purchase product was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase product" do
    visit purchase_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase product was successfully destroyed"
  end
end
