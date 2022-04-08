class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users, id: :string do |t|
      t.string :name
      t.text :description
      t.text :profile_image_url, null: false
      t.timestamps
    end
  end
end
