class CreateSegments < ActiveRecord::Migration[5.2]
  def change
    create_table :segments do |t|
      t.string :name
      t.references :radio, foreign_key: true

      t.timestamps
    end
  end
end
