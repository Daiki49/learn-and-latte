class AddDefaultToUsersNameAndEmail < ActiveRecord::Migration[7.1]
  def up
    change_column :users, :name, :string, default: ""
    change_column :users, :email, :string, default: ""
  end

  def down
    change_column :users, :name, :string, default: nil
    change_column :users, :email, :string, default: nil
  end
end
