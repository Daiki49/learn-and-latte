class ChangePostLikesToLikes < ActiveRecord::Migration[7.1]
  def change
    rename_table :post_likes, :likes
  end
end
