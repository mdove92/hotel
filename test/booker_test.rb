require_relative "test_helper"

describe "Booker class" do
  describe "initialize" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)
    end
    it "get initialized as a type of Booker" do
      expect @book.must_be_kind_of Hotel::Booker
    end
    it "creates an array of 20 hotel Ids" do
      expect @book.room_list.length.must_equal 20
      expect @book.room_list[2].must_be_kind_of Integer
      expect @book.room_list[2].must_equal 3
    end
  end
end
