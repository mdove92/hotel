require "date"

module Hotel
  class DateRange
    attr_reader :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
    end

    def intersects(dateRange)
      # Figure out whether it doesn't intersect
      doesnt_intersect = dateRange.start_date >= @end_date || dateRange.end_date <= @start_date
      # Return the negation of that
      return !doesnt_intersect
    end
  end
end
