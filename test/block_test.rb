require_relative "test_helper"

describe "Block class" do
  before do
    @book = Hotel::Booker.new(number_of_rooms: 20)
  end
  describe "block" do
    it "creates a new block" do
      test_start = "2019/12/17"
      test_end = "2019/12/20"
      date_range = Hotel::DateRange.new(test_start, test_end)
      rooms = [1, 2, 3, 4, 5]
      discounted_rate = 130

      block = Hotel::Block.new(date_range, rooms, discounted_rate)
      expect block.must_be_kind_of Hotel::Block

      expect block.rooms.length.must_equal 5
      expect block.discounted_cost.must_equal 130
      expect block.date_range.must_equal date_range
    end
  end
end
