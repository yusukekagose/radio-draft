class AddStatusToSegments < ActiveRecord::Migration[5.2]
  def change
    add_column :segments, :status, :integer, default: 0
  end
end
