class RemoveRatingFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :rating, :integer
  end
end
