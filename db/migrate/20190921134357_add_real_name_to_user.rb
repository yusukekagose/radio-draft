class AddRealNameToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :encrypted_real_name, :string
    add_column :users, :encrypted_real_name_iv, :string
  end
end
