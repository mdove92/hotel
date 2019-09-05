require_relative "test_helper"

describe "Reservation class" do
  it "get initialized as a type of Reservation" do
    reservation = Hotel::Reservation.new("2019-11-20", "Macaria", 15)
    expect reservation.must_be_kind_of Hotel::Reservation
  end
end
