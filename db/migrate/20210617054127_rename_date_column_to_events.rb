class RenameDateColumnToEvents < ActiveRecord::Migration[6.1]
  def change
    rename_column :events, :date, :start_time
  end
end
