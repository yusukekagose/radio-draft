class AddStatusToDrafts < ActiveRecord::Migration[5.2]
  def change
    add_column :drafts, :status, :integer, default: 0
  end
end
