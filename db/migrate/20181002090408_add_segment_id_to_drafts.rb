class AddSegmentIdToDrafts < ActiveRecord::Migration[5.2]
  def change
    add_column :drafts, :segment_id, :integer
  end
end
