class AddDestinationToRadio < ActiveRecord::Migration[5.2]
  def change
    add_column :radios, :destination, :string
  end
end
