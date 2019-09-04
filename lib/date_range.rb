require "date"

module Hotel
  class DateRange
    def initialize(start_date, end_date)
      @start_date = start_date
      @end_date = end_date
      Date.parse(@start_date)
      Date.parse(@end_date)
    end
  end
end
