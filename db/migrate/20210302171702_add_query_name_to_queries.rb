class AddQueryNameToQueries < ActiveRecord::Migration[6.1]
  def change
    add_column :queries, :query_name, :string
  end
end
