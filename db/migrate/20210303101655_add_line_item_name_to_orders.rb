class AddLineItemNameToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column(:orders, :lineitem_name, :string)
  end
end
