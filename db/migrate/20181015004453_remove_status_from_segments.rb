class RemoveStatusFromSegments < ActiveRecord::Migration[5.2]
  def change
    remove_column :segments, :status, :boolean
  end
end
