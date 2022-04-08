class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items, id: :string do |t|
      t.string :user_id, null: false
      t.string :title, null: false
      t.integer :reactions_count, null: false
      t.integer :likes_count, null: false
      t.timestamps
    end
    add_foreign_key :items, :users
    add_index  :items, :user_id
  end
end
