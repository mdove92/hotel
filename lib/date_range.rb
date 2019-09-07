require "date"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def overlaps?(date_range)
      doesnt_overlap = date_range.start_date >= @end_date || date_range.end_date <= @start_date
      return !doesnt_overlap
    end
  end
end
