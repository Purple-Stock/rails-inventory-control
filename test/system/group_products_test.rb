require "application_system_test_case"

class GroupProductsTest < ApplicationSystemTestCase
  setup do
    @group_product = group_products(:one)
  end

  test "visiting the index" do
    visit group_products_url
    assert_selector "h1", text: "Group Products"
  end

  test "creating a Group product" do
    visit group_products_url
    click_on "New Group Product"

    click_on "Create Group product"

    assert_text "Group product was successfully created"
    click_on "Back"
  end

  test "updating a Group product" do
    visit group_products_url
    click_on "Edit", match: :first

    click_on "Update Group product"

    assert_text "Group product was successfully updated"
    click_on "Back"
  end

  test "destroying a Group product" do
    visit group_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group product was successfully destroyed"
  end
end
