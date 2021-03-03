class AddQueryToFilters < ActiveRecord::Migration[6.1]
  def change
    add_reference :filters, :query, null: false, foreign_key: true
  end
end
