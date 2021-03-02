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

ActiveRecord::Schema.define(version: 2021_03_02_153822) do

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
    t.binary "buyer_accepts_marketing"
    t.string "cancel_reason"
    t.datetime "cancelled_at"
    t.datetime "closed_at"
    t.string "tags"
    t.text "note"
    t.string "phone"
    t.string "referring_site"
    t.datetime "processed_at"
    t.string "source_name"
    t.integer "total_weight"
    t.float "total_tax"
    t.string "shipping_company"
    t.string "shipping_name"
    t.string "shipping_phone"
    t.string "shipping_first_name"
    t.string "shipping_last_name"
    t.string "shipping_address1"
    t.string "shipping_address2"
    t.string "shipping_city"
    t.string "shipping_province"
    t.string "shipping_province_code"
    t.string "shipping_zip"
    t.string "shipping_country"
    t.string "shipping_country_code"
    t.string "billing_company"
    t.string "billing_name"
    t.string "billing_phone"
    t.string "billing_first_name"
    t.string "billing_last_name"
    t.string "billing_address1"
    t.string "billing_address2"
    t.string "billing_city"
    t.string "billing_province"
    t.string "billing_province_code"
    t.string "billing_zip"
    t.string "billing_country"
    t.string "billing_country_code"
    t.string "lineitem_name"
    t.string "lineitem_variant_id"
    t.integer "lineitem_quantity"
    t.float "lineitem_price"
    t.string "lineitem_variant_title"
    t.float "lineitem_compare_at_price"
    t.string "lineitem_sku"
    t.boolean "lineitem_requires_shipping"
    t.boolean "lineitem_taxable"
    t.string "lineitem_fulfillment_status"
    t.boolean "taxes_included"
    t.string "tax_1_title"
    t.float "tax_1_price"
    t.float "tax_1_rate"
    t.string "tax_2_title"
    t.float "tax_2_price"
    t.float "tax_2_rate"
    t.string "tax_3_title"
    t.float "tax_3_price"
    t.float "tax_3_rate"
    t.float "transaction_amount"
    t.string "transaction_kind"
    t.string "transaction_status"
    t.datetime "transaction_processed_at"
    t.string "transaction_gateway"
    t.string "transaction_location_id"
    t.string "transaction_source_name"
    t.string "shipping_line_code"
    t.float "shipping_line_price"
    t.string "shipping_line_source"
    t.string "shipping_line_title"
    t.string "shipping_line_carrier_identifier"
    t.string "shipping_line_requested_fulfillment_service_id"
    t.string "shipping_tax_1_title"
    t.float "shipping_tax_1_rate"
    t.float "shipping_tax_price"
    t.string "discount_code"
    t.float "discount_amount"
    t.string "discount_type"
    t.string "metafield_namespace"
    t.string "metafield_key"
    t.text "metafield_value"
    t.string "metafield_value_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
