require_relative "test_helper"

describe "Reservation class" do
  describe "initialize" do
    it "get initialized as a type of Reservation" do
      reservation = Hotel::Reservation.new("2019/11/29", "2019/12/01", 12)
      expect reservation.must_be_kind_of Hotel::Reservation
    end
  end
end
