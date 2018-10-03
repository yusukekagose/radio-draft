class FixColumnName < ActiveRecord::Migration[5.2]
  def change
    rename_column :radio_speakers, :radio, :radio_id
    rename_column :radio_speakers, :speaker, :speaker_id
  end
end
