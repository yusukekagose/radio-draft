class CreateRadioSpeakers < ActiveRecord::Migration[5.2]
  def change
    create_table :radio_speakers do |t|
      t.integer :radio
      t.integer :speaker

      t.timestamps
    end
  end
end
