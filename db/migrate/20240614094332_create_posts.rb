class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.references :user, foreign_key: true
      t.references :shop, foreign_key: true
      t.string :title
      t.text :body
      t.integer :quietness_level, null: false
      t.integer :seat_comfort_level, null: false
      t.integer :wifi_comfort_level, null: false
      t.integer :power_availability, null: false

      t.timestamps
    end
  end
end
