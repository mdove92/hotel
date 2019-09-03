require_relative "test_helper"

describe "Room class" do
  it "get initialized as a type of Room" do
    room = Hotel::Room.new
    expect room.must_be_kind_of Hotel::Room
  end
end
