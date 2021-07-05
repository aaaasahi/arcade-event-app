class RemovePrefectureIdToEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :prefecture_id, :integer
  end
end
