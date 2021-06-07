class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false
      t.string :name
      t.text :introduction
      t.integer :gender
      t.date :age
      t.timestamps
    end
  end
end
