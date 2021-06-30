class AddNewColumnsToAddress < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :lat, :float
    add_column :addresses, :lng, :float
  end
end
