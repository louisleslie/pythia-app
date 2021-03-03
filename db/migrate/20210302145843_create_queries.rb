class CreateQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :queries do |t|
      t.text :fields
      t.references :csv_file, null: false, foreign_key: true

      t.timestamps
    end
  end
end
