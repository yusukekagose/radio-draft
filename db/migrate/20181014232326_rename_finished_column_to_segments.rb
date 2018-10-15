class RenameFinishedColumnToSegments < ActiveRecord::Migration[5.2]
  def change
    rename_column :segments, :finished, :status
  end
end
