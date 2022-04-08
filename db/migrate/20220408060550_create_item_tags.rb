class CreateItemTags < ActiveRecord::Migration[6.0]
  def change
    create_table :item_tags do |t|
      t.string :item_id, null: false
      t.references :tag, foreign_key: true, null: false
      t.timestamps
    end
    add_foreign_key :item_tags, :items
    add_index  :item_tags, :item_id
  end
end
