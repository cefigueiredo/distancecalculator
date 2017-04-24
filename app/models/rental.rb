class Rental < ApplicationRecord
  validates_presence_of :positions

  def sorted_positions
    positions.sort { |a,b| a['time'].to_i <=> b['time'].to_i }
  end
end
