class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true
      t.text :content, null: false

      t.timestamps
    end
  end
end
