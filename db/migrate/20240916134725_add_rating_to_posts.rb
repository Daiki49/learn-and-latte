class AddRatingToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :rating, :integer
  end
end
