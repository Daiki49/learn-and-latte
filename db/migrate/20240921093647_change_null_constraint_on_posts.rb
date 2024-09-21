class ChangeNullConstraintOnPosts < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :rating, false
  end
end
