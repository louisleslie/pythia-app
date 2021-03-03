class AddMoreToOrders < ActiveRecord::Migration[6.1]
  def change
  add_column(:orders, :discount_code, :string)
  add_column(:orders, :discount_amount, :float)
  add_column(:orders, :lineitem_quantity, :integer)
  add_column(:orders, :lineitem_price, :float)
  add_column(:orders, :lineitem_sku, :string)
  add_column(:orders, :lineitem_requires_shipping, :boolean)
  add_column(:orders, :billing_address1, :string)
  add_column(:orders, :billing_address2, :string)
  add_column(:orders, :billing_city, :string)
  add_column(:orders, :lineitem_taxable, :boolean)
  add_column(:orders, :lineitem_fulfillment_status, :string)
  add_column(:orders, :lineitem_compare_at_price, :float)
  add_column(:orders, :billing_name, :string)
  add_column(:orders, :billing_company, :string)
  add_column(:orders, :billing_zip, :string)

  add_column(:orders, :billing_province, :string)
  add_column(:orders, :billing_country, :string)
  end
end
