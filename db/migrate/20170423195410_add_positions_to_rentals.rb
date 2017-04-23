class AddPositionsToRentals < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :positions, :json
  end
end
