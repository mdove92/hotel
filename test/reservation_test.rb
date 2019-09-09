require_relative "test_helper"

describe "Reservation class" do
  describe "initialize" do
    before do
      test_start = "2019/12/17"
      test_end = "2019/12/20"
      date_range = Hotel::DateRange.new(test_start, test_end)
      @reservation = Hotel::Reservation.new(date_range, 12)
    end
    it "gets initialized as a type of Reservation" do
      expect @reservation.must_be_kind_of Hotel::Reservation
    end
  end
  describe "cost" do
    it "returns a number" do
      test_start = "2019/12/17"
      test_end = "2019/12/20"
      date_range = Hotel::DateRange.new(test_start, test_end)
      reservation = Hotel::Reservation.new(date_range, 12)
      expect(reservation.cost).must_be_kind_of Numeric
    end
  end
end
