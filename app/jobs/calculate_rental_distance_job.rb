class CalculateRentalDistanceJob < ApplicationJob
  queue_as :default

  def perform(rental_id)
    rental = Rental.find(rental_id)
    google_maps = GoogleMaps::Directions.new

    directions = google_maps.get_batched_directions rental.sorted_positions
    rental.polylines = directions[:paths]
    rental.total_distance = directions[:total_distance] * 0.001 #convert to km
    rental.status = 'processed'
  rescue StandardError => e
    rental.status = 'error_processing'
    raise e
  ensure
    rental.save
  end
end
