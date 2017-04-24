class AddPathPolylinesToRental < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :polylines, :json
  end
end
