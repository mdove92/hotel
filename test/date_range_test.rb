require_relative "test_helper"

describe "DateRange class" do
  it "get initialized as a type of DateRange" do
    dates = Hotel::DateRange.new("2019/08/30", "2019/09/09")
    expect dates.must_be_kind_of Hotel::DateRange
  end
end
