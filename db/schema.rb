# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 0) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "companyId"
  end

  create_table "companies", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "trade", limit: 255
    t.string "cnpj", limit: 18, null: false
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "userId"
  end

  create_table "customers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "cellphone", limit: 255, null: false
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "companyId"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.float "price", null: false
    t.string "code", limit: 255, null: false
    t.string "imageUrl", limit: 255
    t.boolean "highlight"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "categoryId"
    t.integer "companyId"
  end

  create_table "purchaseItems", id: :serial, force: :cascade do |t|
    t.integer "quantity"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "productId"
    t.integer "purchaseId"
    t.index ["productId", "purchaseId"], name: "purchaseItems_productId_purchaseId_key", unique: true
  end

  create_table "purchases", id: :serial, force: :cascade do |t|
    t.float "value", null: false
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "supplierId"
    t.integer "companyId"
  end

  create_table "saleItems", id: :serial, force: :cascade do |t|
    t.integer "quantity"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "productId"
    t.integer "saleId"
    t.index ["productId", "saleId"], name: "saleItems_productId_saleId_key", unique: true
  end

  create_table "sales", id: :serial, force: :cascade do |t|
    t.float "value", null: false
    t.float "discount", null: false
    t.float "percentage", null: false
    t.boolean "online", null: false
    t.boolean "disclosure"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "customerId"
    t.integer "companyId"
  end

  create_table "suppliers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "cnpj", limit: 18
    t.string "email", limit: 255, null: false
    t.string "cellphone", limit: 255, null: false
    t.string "address", limit: 255, null: false
    t.string "city", limit: 255, null: false
    t.string "state", limit: 255, null: false
    t.string "landmark", limit: 255
    t.string "note", limit: 255
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "companyId"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "lastname", limit: 255, null: false
    t.string "email", limit: 255, null: false
    t.string "password", limit: 255, null: false
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
  end

  add_foreign_key "categories", "companies", column: "companyId", name: "categories_companyId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "companies", "users", column: "userId", name: "companies_userId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "customers", "companies", column: "companyId", name: "customers_companyId_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "products", "categories", column: "categoryId", name: "products_categoryId_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "products", "companies", column: "companyId", name: "products_companyId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchaseItems", "products", column: "productId", name: "purchaseItems_productId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchaseItems", "purchases", column: "purchaseId", name: "purchaseItems_purchaseId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchases", "companies", column: "companyId", name: "purchases_companyId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "purchases", "suppliers", column: "supplierId", name: "purchases_supplierId_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "saleItems", "products", column: "productId", name: "saleItems_productId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "saleItems", "sales", column: "saleId", name: "saleItems_saleId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sales", "companies", column: "companyId", name: "sales_companyId_fkey", on_update: :cascade, on_delete: :cascade
  add_foreign_key "sales", "customers", column: "customerId", name: "sales_customerId_fkey", on_update: :cascade, on_delete: :nullify
  add_foreign_key "suppliers", "companies", column: "companyId", name: "suppliers_companyId_fkey", on_update: :cascade, on_delete: :nullify
end
