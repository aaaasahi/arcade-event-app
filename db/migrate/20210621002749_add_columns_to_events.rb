class AddColumnsToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :address, :string
    add_column :events, :latitude, :float
    add_column :events, :longitude, :float
  end
end
