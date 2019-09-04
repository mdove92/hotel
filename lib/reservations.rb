require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :guest, :room

    def initialize(date_range, guest)
      @date_range = date_range
      @guest = guest
      @room = room
    end
  end
end
