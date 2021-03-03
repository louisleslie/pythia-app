class CreateFilters < ActiveRecord::Migration[6.1]
  def change
    create_table :filters do |t|
      t.string :comparison_operator
      t.string :column_name
      t.string :value
      t.string :verb

      t.timestamps
    end
  end
end
