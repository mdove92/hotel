require_relative "test_helper"

describe "Booker class" do
  it "get initialized as a type of Booker" do
    book = Hotel::Booker.new
    expect book.must_be_kind_of Hotel::Booker
  end
end
