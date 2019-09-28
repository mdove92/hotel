module Hotel
  class Block
    attr_reader :date_range, :rooms, :discounted_cost

    def initialize(date_range, rooms, discounted_cost)
      @date_range = date_range
      @rooms = rooms
      @discounted_cost = discounted_cost
    end

    def validate(is_room_available)
      if @rooms.length > 5 || !is_room_available
        throw ArgumentError.new("More than 5 rooms in block")
      end
    end
  end
end
