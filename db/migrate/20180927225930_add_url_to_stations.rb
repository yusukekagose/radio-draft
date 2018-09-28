class AddUrlToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :url, :string
  end
end
