require "date"

module Hotel
  class Booker
    attr_reader :guests, :rooms
    attr_accessor :reservations

    def initialize
      @guests = guests
      @rooms = rooms
      @reservations = reservations
      connect_res
    end

    #     attr_accessor :roomList
    # def initialize(numberOfRooms)
    #     @roomList = []
    #     while numberOfRooms > 0
    #     roomList.push(Room.new(rumberOfRooms))
    #     numberOfRooms-=1
    #     end

  end

=begin
    User Stories

    As a user of the hotel system...
        I can access the list of all of the rooms in the hotel
        I can get a reservation of a room for a given date range
        I can access the list of reservations for a specific date, so that I can track reservations by date
        I can get the total cost for a given reservation
        I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range

Details

    The hotel has 20 rooms, and they are numbered 1 through 20
    Every room is identical, and a room always costs $200/night
    The last day of a reservation is the checkout day, so the guest should not be charged for that night
    When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
    For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
=end
  private

  def connect_res
    @reservations.each do |reservation|
      guest = find_guest(reservation.guest_name)
    end
  end
end
