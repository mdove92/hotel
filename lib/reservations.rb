require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :guest, :room_id

    def initialize(start_date, end_date, room_id)
      @start_date = start_date
      @end_date = end_date
      @room_id = room_id
      @date_range = Hotel::DateRange.new(@start_date, @end_date)
    end

    def cost
      stay_length = @date_range.duration
      cost = stay_length * 200
      return cost
    end

    #def available?(date_range, room_id)
    # end
    #def make_reservation(date_range, room_id)
    #room.status = :UNAVAILABLE
    #end
  end
end
