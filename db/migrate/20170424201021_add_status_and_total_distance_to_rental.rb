class AddStatusAndTotalDistanceToRental < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :status, :string
    add_column :rentals, :total_distance, :numeric
  end
end
