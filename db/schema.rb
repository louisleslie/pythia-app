# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_03_101655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "csv_files", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "filename"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_csv_files_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "csv_file_id", null: false
    t.float "longitude"
    t.float "latitude"
    t.text "full_billing_address"
    t.string "name"
    t.string "email"
    t.string "financial_status"
    t.string "fulfillment_status"
    t.string "currency"
    t.datetime "cancelled_at"
    t.string "tags"
    t.string "shipping_company"
    t.string "shipping_name"
    t.string "shipping_address1"
    t.string "shipping_address2"
    t.string "shipping_city"
    t.string "shipping_province"
    t.string "shipping_zip"
    t.string "shipping_country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "paid_at"
    t.datetime "fulfilled_at"
    t.boolean "accepts_marketing"
    t.float "subtotal"
    t.float "shipping"
    t.float "taxes"
    t.float "total"
    t.string "shipping_method"
    t.datetime "order_created_at"
    t.string "billing_street"
    t.string "shipping_street"
    t.string "payment_method"
    t.float "refunded_amount"
    t.string "vendor"
    t.string "order_id"
    t.string "risk_level"
    t.string "source"
    t.float "lineitem_discount"
    t.string "receipt_number"
    t.string "billing_province_name"
    t.string "shipping_province_name"
    t.string "discount_code"
    t.float "discount_amount"
    t.integer "lineitem_quantity"
    t.float "lineitem_price"
    t.string "lineitem_sku"
    t.boolean "lineitem_requires_shipping"
    t.string "billing_address1"
    t.string "billing_address2"
    t.string "billing_city"
    t.boolean "lineitem_taxable"
    t.string "lineitem_fulfillment_status"
    t.float "lineitem_compare_at_price"
    t.string "billing_name"
    t.string "billing_company"
    t.string "billing_zip"
    t.string "billing_province"
    t.string "billing_country"
    t.string "lineitem_name"
    t.index ["csv_file_id"], name: "index_orders_on_csv_file_id"
  end

  create_table "queries", force: :cascade do |t|
    t.text "fields"
    t.bigint "csv_file_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["csv_file_id"], name: "index_queries_on_csv_file_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "csv_files", "users"
  add_foreign_key "orders", "csv_files"
  add_foreign_key "queries", "csv_files"
end
