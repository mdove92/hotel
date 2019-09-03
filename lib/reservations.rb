require "date"

module Hotel
  class Reservation
    def initialize
      @date_range = date_range
      @room = room
    end
  end
end
