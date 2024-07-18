class ChangeJsonToJsonbInPosts < ActiveRecord::Migration[7.1]
  def up
    change_column :posts, :post_images, :jsonb
  end
  def down
    change_column :posts, :post_images, :json
  end
end
