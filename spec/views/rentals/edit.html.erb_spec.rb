require 'rails_helper'

RSpec.describe "rentals/edit", type: :view do
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
    @rental = assign(:rental, Rental.create!(valid_attributes))
  end

  it "renders the edit rental form" do
    render

    assert_select "form[action=?][method=?]", rental_path(@rental), "post" do
    end
  end
end
