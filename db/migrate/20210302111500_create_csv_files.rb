class CreateCsvFiles < ActiveRecord::Migration[6.1]
  def change
    create_table :csv_files do |t|
      t.references :user, null: false, foreign_key: true
      t.string :filename

      t.timestamps
    end
  end
end
