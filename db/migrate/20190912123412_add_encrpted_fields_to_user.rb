class AddEncrptedFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :encrypted_address, :string
    add_column :users, :encrypted_address_iv, :string
    add_column :users, :encrypted_postal_code, :string
    add_column :users, :encrypted_postal_code_iv, :string
  end
end
