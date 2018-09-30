class CreateRadios < ActiveRecord::Migration[5.2]
  def change
    create_table :radios do |t|
      t.string :name
      t.string :url
      t.string :img
      t.references :station, foreign_key: true

      t.timestamps
    end
  end
end
