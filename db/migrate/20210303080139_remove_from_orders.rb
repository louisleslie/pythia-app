class RemoveFromOrders < ActiveRecord::Migration[6.1]
  def change
    remove_column(:orders, :buyer_accepts_marketing)
    remove_column(:orders, :cancel_reason)
    remove_column(:orders, :closed_at)
    remove_column(:orders, :note)
    remove_column(:orders, :phone)
    remove_column(:orders, :referring_site)
    remove_column(:orders, :processed_at)
    remove_column(:orders, :source_name)
    remove_column(:orders, :total_weight)
    remove_column(:orders, :total_tax)
    remove_column(:orders, :shipping_phone)
    remove_column(:orders, :shipping_first_name)
    remove_column(:orders, :shipping_last_name)
    remove_column(:orders, :shipping_province_code)
    remove_column(:orders, :shipping_country_code)
    remove_column(:orders, :billing_company)
    remove_column(:orders, :billing_name)
    remove_column(:orders, :billing_phone)
    remove_column(:orders, :billing_first_name)
    remove_column(:orders, :billing_last_name)
    remove_column(:orders, :billing_address1)
    remove_column(:orders, :billing_address2)
    remove_column(:orders, :billing_city)
    remove_column(:orders, :billing_province)
    remove_column(:orders, :billing_province_code)
    remove_column(:orders, :billing_zip)
    remove_column(:orders, :billing_country)
    remove_column(:orders, :billing_country_code)
    remove_column(:orders, :lineitem_name)
    remove_column(:orders, :lineitem_variant_id)
    remove_column(:orders, :lineitem_quantity)
    remove_column(:orders, :lineitem_price)
    remove_column(:orders, :lineitem_variant_title)
    remove_column(:orders, :lineitem_compare_at_price)
    remove_column(:orders, :lineitem_sku)
    remove_column(:orders, :lineitem_requires_shipping)
    remove_column(:orders, :lineitem_taxable)
    remove_column(:orders, :lineitem_fulfillment_status)
    remove_column(:orders, :taxes_included)
    remove_column(:orders, :tax_1_title)
    remove_column(:orders, :tax_1_price)
    remove_column(:orders, :tax_1_rate)
    remove_column(:orders, :tax_2_title)
    remove_column(:orders, :tax_2_price)
    remove_column(:orders, :tax_2_rate)
    remove_column(:orders, :tax_3_title)
    remove_column(:orders, :tax_3_price)
    remove_column(:orders, :tax_3_rate)
    remove_column(:orders, :transaction_amount)
    remove_column(:orders, :transaction_kind)
    remove_column(:orders, :transaction_status)
    remove_column(:orders, :transaction_processed_at)
    remove_column(:orders, :transaction_gateway)
    remove_column(:orders, :transaction_location_id)
    remove_column(:orders, :transaction_source_name)
    remove_column(:orders, :shipping_line_code)
    remove_column(:orders, :shipping_line_price)
    remove_column(:orders, :shipping_line_source)
    remove_column(:orders, :shipping_line_title)
    remove_column(:orders, :shipping_line_carrier_identifier)
    remove_column(:orders, :shipping_line_requested_fulfillment_service_id)
    remove_column(:orders, :shipping_tax_1_title)
    remove_column(:orders, :shipping_tax_1_rate)
    remove_column(:orders, :shipping_tax_price)
    remove_column(:orders, :discount_code)
    remove_column(:orders, :discount_amount)
    remove_column(:orders, :discount_type)
    remove_column(:orders, :metafield_namespace)
    remove_column(:orders, :metafield_key)
    remove_column(:orders, :metafield_value)
    remove_column(:orders, :metafield_value_type)
  end
end