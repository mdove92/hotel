require_relative "test_helper"

describe "Reservation class" do
  describe "cost" do
    it "returns a number" do
      test_start = "2019/12/17"
      test_end = "2019/12/20"

      reservation = Hotel::Reservation.new(test_start, test_end, 12)
      expect(reservation.cost).must_be_kind_of Numeric
    end
  end
end
