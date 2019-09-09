require "date"

module Hotel
  class Reservation
    attr_reader :date_range, :guest, :room_id

    def initialize(date_range, room_id, rate = 200)
      @room_id = room_id
      @date_range = date_range
      @rate = rate
    end

    def cost
      stay_length = @date_range.duration
      cost = stay_length * @rate
      return cost
    end
  end
end
