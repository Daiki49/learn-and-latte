class AddProvisionalShopNameToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :provisional_shop_name, :string
    add_column :posts, :provisional_shop_address, :string
  end
end
