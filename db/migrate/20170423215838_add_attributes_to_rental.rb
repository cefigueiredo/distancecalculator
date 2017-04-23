class AddAttributesToRental < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :car_model, :string
  end
end
