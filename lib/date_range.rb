require "date"

module Hotel
  class DateRange
    attr_accessor :start_date, :end_date

    def initialize(start_date, end_date)
      @start_date = Date.parse(start_date)
      @end_date = Date.parse(end_date)
      if duration < 0
        raise ArgumentError.new("Invalid date range input")
      end
    end

    def overlaps?(date_range)
      doesnt_overlap = date_range.start_date >= @end_date || date_range.end_date <= @start_date
      return !doesnt_overlap
    end

    def duration
      stay_length = (@end_date - @start_date).to_i
      return stay_length
    end
  end
end
