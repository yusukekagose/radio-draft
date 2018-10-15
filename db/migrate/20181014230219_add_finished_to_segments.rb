class AddFinishedToSegments < ActiveRecord::Migration[5.2]
  def change
    add_column :segments, :finished, :boolean, default: false
  end
end
