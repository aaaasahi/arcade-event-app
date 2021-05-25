class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.references :user, null: false
      t.string :name, null: false
      t.text :text, null: false
      t.string :store
      t.date :date

      t.timestamps
    end
  end
end
