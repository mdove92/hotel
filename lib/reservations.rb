require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :guest, :room

    def initialize(room)
      @date_range = date_range
      @guest = guest
      @room = room
    end

    #def available?(date_range, room_id)
    # end
    #def make_reservation(date_range, room_id)
    #room.status = :UNAVAILABLE
    #end
  end
end
