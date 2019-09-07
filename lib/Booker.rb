=begin
    User Stories
​
    As a user of the hotel system...
        I can access the list of all of the rooms in the hotel
        I can get a reservation of a room for a given date range
        I can access the list of reservations for a specific date, so that I can track reservations by date
        I can get the total cost for a given reservation
        I want exception raised when an invalid date range is provided, so that I can't make a reservation for an invalid date range
​
Details
​
    The hotel has 20 rooms, and they are numbered 1 through 20
    Every room is identical, and a room always costs $200/night
    The last day of a reservation is the checkout day, so the guest should not be charged for that night
    When reserving a room, the user provides only the start and end dates - the library should determine which room to use for the reservation
    For this wave, any room can be reserved at any time, and you don't need to check whether reservations conflict with each other (this will come in wave 2!)
=end

module Hotel
  class Booker
    attr_reader :guests, :rooms
    attr_accessor :reservations, :room_list

    def initialize(number_of_rooms: 20)
      @guests = []
      #HashMap<reservation_id, HashMap <room_id, date_range>>
      @reservations_history = {}

      #Integer reservation_id =0;
      @current_reservation_id = 0

      #Initialize the reservations_list hashmap
      @reservations = {}

      room_id = 1

      @room_list = []
      while room_id <= number_of_rooms
        room_list.push(room_id)
        @reservations[room_id] = []
        room_id += 1
      end
    end

    def select_room #Selects a room for a reservation on a given date
    end

    def get_reservation(reservation_id)
      return @reservations_history[reservation_id]
    end

    def make_reservation(date_range)
      room_reserved = false
      room_id = get_available_room(date_range)
      if (room_id != 0)
        room_reserved = reservation.add_reservation(room_id, date_range)
      end

      if (room_reserved)
        room_booked = {}
        room_booked[room_id] = date_range
        reservations_history.add(@current_reservation_id += 1, room_booked)
      end
    end

    def add_reservation(room_id, date_range)
      #Adds new date_range to the specific room if date_range is not booked and returns success code 0. Else returns code 1.
      if (@reservations.key?(room_id) && room_available?(room_id, date_range))
        @reservations[room_id].push(date_range)
        return true
      end
      return false
    end

    def remove_reservation(room_id, date_range)
      #Removes the given date_range from the list for the given room
      if (@reservations.key?(room_id))
        @reservations[room_id].delete(date_range)
      end
    end

    def get_available_room(date)
      available_room = 0
      @reservations.each_key do |room_id|
        is_room_available = room_available?(room_id, date)
        if is_room_available
          available_room = room_id
        end
      end

      return available_room
    end

    def room_available?(room_id, date)
      is_room_available = true
      @reservations[room_id].each do |reserved_date|
        if (date.intersects(reserved_date))
          is_room_available = false
          break
        end
      end

      return is_room_available
    end

    def get_reserved_rooms(date)
      #Get the list of list of date_range (values of the hashmap) and iterate thru the list. When the date matches get the key(room_id) and store in local list. Return the list of rooms
      reserved_rooms = []
      @reservations.each_key do |room_id|
        @reservations[room_id].each do |date_range|
          if date == date_range
            reserved_rooms.push(room_id)
            break
          end
        end
      end
      return reserved_rooms
    end

    private

    def connect_res
      # @reservations.each do |reservation|
      #   guest = find_guest(reservation.guest_name)
      # end
    end
  end
end
