class ChangeColumnDefaultToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :uid, nil
    change_column_default :users, :provider, nil
  end
end
