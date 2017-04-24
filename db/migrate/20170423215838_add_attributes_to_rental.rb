class AddAttributesToRental < ActiveRecord::Migration[5.0]
  def change
    add_column :rentals, :name, :string
  end
end
