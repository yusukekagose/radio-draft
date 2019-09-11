class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :radio_name, :string
    add_column :users, :address, :string
    add_column :users, :postal_code, :string
    add_column :users, :send_from, :string
  end
end
