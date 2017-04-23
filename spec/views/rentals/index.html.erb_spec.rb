require 'rails_helper'

RSpec.describe "rentals/index", type: :view do
  let(:valid_attributes) {
    {
      positions: {
        start_position: { time: 1472829721, lat: 48.09197, lng: -1.65535 },
        end_position: { time: 1472829721, lat: 48.09197, lng: -1.65535 },
        transit_positions: []
      }
    }
  }

  before(:each) do
    assign(:rentals, [
      Rental.create!(valid_attributes),
      Rental.create!(valid_attributes)
    ])
  end

  it "renders a list of rentals" do
    render
  end
end
