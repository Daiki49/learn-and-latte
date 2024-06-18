class RemoveProvisionalShopNameFromPosts < ActiveRecord::Migration[7.1]
  def change
    remove_column :posts, :provisional_shop_name, :string
    remove_column :posts, :provisional_shop_address, :string
  end
end
