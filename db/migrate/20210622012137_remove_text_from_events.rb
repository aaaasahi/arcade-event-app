class RemoveTextFromEvents < ActiveRecord::Migration[6.1]
  def change
    remove_column :events, :text, :text
  end
end
