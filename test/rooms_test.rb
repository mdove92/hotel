require_relative "test_helper"

describe "Room class" do
  it "get initialized as a type of Room" do
    room = Hotel::Room.new(id: 1, status: :AVAILABLE)
    expect room.must_be_kind_of Hotel::Room
  end
  it "has a default status of :AVAILABLE" do
    expect(Hotel::Room.new(id: 1, status: :AVAILABLE).status).must_equal :AVAILABLE
  end
end
