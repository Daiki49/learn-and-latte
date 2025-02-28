class ChangePostsColumnsToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :quietness_level, true
    change_column_null :posts, :seat_comfort_level, true
    change_column_null :posts, :wifi_comfort_level, true
    change_column_null :posts, :power_availability, true
  end
end
