class CreateDrafts < ActiveRecord::Migration[5.2]
  def change
    create_table :drafts do |t|
      t.string :title
      t.text :content
      t.references :radio, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
