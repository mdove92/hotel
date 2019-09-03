require "date"

module Hotel
  class Booker
    attr_reader :guests, :rooms
    attr_accessor :reservations

    def initialize
      @guests = guests
      @rooms = rooms
      @reservations = reservations
    end
  end
end
