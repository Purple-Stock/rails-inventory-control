require "application_system_test_case"

class SuppliersTest < ApplicationSystemTestCase
  setup do
    @supplier = suppliers(:one)
  end

  test "visiting the index" do
    visit suppliers_url
    assert_selector "h1", text: "Suppliers"
  end

  test "creating a Supplier" do
    visit suppliers_url
    click_on "New Supplier"

    fill_in "Address", with: @supplier.address
    fill_in "Cellphone", with: @supplier.cellphone
    fill_in "City", with: @supplier.city
    fill_in "Cnpj", with: @supplier.cnpj
    fill_in "Email", with: @supplier.email
    fill_in "Landmark", with: @supplier.landmark
    fill_in "Name", with: @supplier.name
    fill_in "Note", with: @supplier.note
    fill_in "Phone", with: @supplier.phone
    fill_in "State", with: @supplier.state
    click_on "Create Supplier"

    assert_text "Supplier was successfully created"
    click_on "Back"
  end

  test "updating a Supplier" do
    visit suppliers_url
    click_on "Edit", match: :first

    fill_in "Address", with: @supplier.address
    fill_in "Cellphone", with: @supplier.cellphone
    fill_in "City", with: @supplier.city
    fill_in "Cnpj", with: @supplier.cnpj
    fill_in "Email", with: @supplier.email
    fill_in "Landmark", with: @supplier.landmark
    fill_in "Name", with: @supplier.name
    fill_in "Note", with: @supplier.note
    fill_in "Phone", with: @supplier.phone
    fill_in "State", with: @supplier.state
    click_on "Update Supplier"

    assert_text "Supplier was successfully updated"
    click_on "Back"
  end

  test "destroying a Supplier" do
    visit suppliers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Supplier was successfully destroyed"
  end
end
