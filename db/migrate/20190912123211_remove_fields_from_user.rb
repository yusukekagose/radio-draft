class RemoveFieldsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :address, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :send_from, :string
  end
end
