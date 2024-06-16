class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.integer :phone_number
      t.string :opening_hours
      t.float :latitude
      t.float :longtitude
      t.string :place_id

      t.timestamps
    end
  end
end
