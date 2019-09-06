require_relative "test_helper"

describe "Reservation class" do
  it "get initialized as a type of Reservation" do
    reservation = Hotel::Reservation.new(12)
    expect reservation.must_be_kind_of Hotel::Reservation
  end
end
