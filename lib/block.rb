module Hotel
  class Block
    attr_reader :date_range, :rooms, :discounted_cost

    def initialize(date_range, rooms, discounted_cost)
      @date_range = date_range
      @rooms = rooms
      @discounted_cost = discounted_cost
    end
  end
end
