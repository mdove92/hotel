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

      it "raises an argument error for a invalid date range" do
        start_date = "2019/12/27"
        end_date = "2019/12/26"

        expect { Hotel::DateRange.new(start_date, end_date) }.must_raise ArgumentError
      end
    end

    describe "overlaps?" do
      before do
        start_date = "2019/12/25"
        end_date = "2019/12/29"

        @range = Hotel::DateRange.new(start_date, end_date)
        @start_date = @range.start_date
        @end_date = @range.end_date
      end

      it "returns true for the same range" do
        test_range = @range

        expect(@range.overlaps?(test_range)).must_equal true
      end

      it "returns true for a contained range" do
        test_start = "2019/12/26"
        test_end = "2019/12/28"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal true
      end

      it "returns true for a range that overlaps in front" do
        test_start = "2019/12/24"
        test_end = "2019/12/27"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal true
      end

      it "returns true for a range that overlaps in the back" do
        test_start = "2019/12/27"
        test_end = "2019/12/30"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal true
      end

      it "returns true for a containing range" do
        test_start = "2019/12/23"
        test_end = "2019/12/30"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal true
      end

      it "returns false for a range starting on the end_date date" do
        test_start = "2019/12/29"
        test_end = "2019/12/30"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal false
      end

      it "returns false for a range ending on the start_date date" do
        test_start = "2019/12/21"
        test_end = "2019/12/25"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal false
      end

      it "returns false for a range completely before" do
        test_start = "2019/12/17"
        test_end = "2019/12/20"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal false
      end

      it "returns false for a date completely after" do
        test_start = "2020/01/25"
        test_end = "2020/01/30"
        test_range = Hotel::DateRange.new(test_start, test_end)
        expect(@range.overlaps?(test_range)).must_equal false
      end
    end

    describe "duration" do
      it "returns the correct number of nights" do
        start_date = "2019/12/25"
        end_date = "2019/12/29"

        range = Hotel::DateRange.new(start_date, end_date)

        expect(range.duration).must_equal 4
      end
    end
  end
end
