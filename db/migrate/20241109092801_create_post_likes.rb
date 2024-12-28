class CreatePostLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :post_likes do |t|
      t.references :user, foreign_key: true
      t.references :post, foreign_key: true
      t.timestamps
    end
    add_index :post_likes, [:user_id, :post_id], unique: true
  end
end
