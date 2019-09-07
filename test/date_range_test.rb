require_relative "test_helper"

describe "DateRange class" do
  it "get initialized as a type of DateRange" do
    dates = Hotel::DateRange.new("2019/08/30", "2019/09/09")
    expect dates.must_be_kind_of Hotel::DateRange
  end

  describe Hotel::DateRange do
    describe "initialize" do
      it "Can be initialized with two dates" do
        start_date = "2019/12/25"
        end_date = "2019/12/29"

        range = Hotel::DateRange.new(start_date, end_date)

        expect(range.start_date).must_equal Date.parse(start_date)
        expect(range.end_date).must_equal Date.parse(end_date)
      end

      xit "raises an argument error for a invalid date range" do
      end
    end

    describe "overlaps?" do
      before do
        start_date = "2019/12/25"
        end_date = "2019/12/29"

        @range = Hotel::DateRange.new(start_date, end_date)
      end

      it "returns true for the same range" do
        start_date = @range.start_date
        end_date = @range.end_date
        test_range = @range

        expect(@range.overlaps?(test_range)).must_equal true
      end

      xit "returns true for a contained range" do
      end

      xit "returns true for a range that overlaps in front" do
      end

      xit "returns true for a range that overlaps in the back" do
      end

      xit "returns true for a containing range" do
      end

      xit "returns false for a range starting on the end_date date" do
      end

      xit "returns false for a range ending on the start_date date" do
      end

      xit "returns false for a range completely before" do
      end

      xit "returns false for a date completely after" do
      end
    end

    xdescribe "duration" do
      it "returns the correct number of nights" do
      end
    end
  end
end
