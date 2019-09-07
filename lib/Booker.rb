

module Hotel
  class Booker
    attr_reader :rooms
    attr_accessor :reservations, :room_list

    def initialize(number_of_rooms: 20)

      #Hash reservation id to reservation
      @reservations_history = {}

      @current_reservation_id = 0

      # hash of room id to an array of date_ranges
      @reservations = {}

      room_id = 1

      @room_list = []
      while room_id <= number_of_rooms
        room_list.push(room_id)
        @reservations[room_id] = []
        room_id += 1
      end
    end

    def select_room(date_range)
      available_room = 0
      @reservations.each_key do |room_id|
        is_room_available = room_available?(room_id, date_range)
        if is_room_available
          available_room = room_id
        end
      end

      return available_room #Selects a room for a reservation on a given date
    end

    # def get_reservation(reservation_id)
    #   return @reservations_history[reservation_id]
    # end

    def make_reservation(start_date, end_date)
      room_reserved = false
      date_range = Hotel::DateRange.new(start_date, end_date)
      room_id = select_room(date_range)
      if (room_id != 0)
        # room_reserved = add_reservation(room_id, date_range)
        room_booked = Hotel::Reservation.new(start_date, end_date, room_id)
        @reservations[room_id].push(room_booked)
        @reservations_history[@current_reservation_id += 1] = room_booked
      end
      return @current_reservation_id
    end

    # def add_reservation(room_id, date_range)
    #   #Adds new date_range to the specific room if date_range is not booked and returns success code 0. Else returns code 1.
    #   if (@reservations.key?(room_id) && room_available?(room_id, date_range))
    #     @reservations[room_id].push(date_range)
    #     return true
    #   end
    #   return false
    # end

    def remove_reservation(room_id, reservation)
      #Removes the given date_range from the list for the given room
      if (@reservations.key?(room_id))
        @reservations[room_id].delete(reservation)
      end
    end

    def room_available?(room_id, date)
      is_room_available = true
      @reservations[room_id].each do |reservation|
        if (date.overlaps?(reservation.date_range))
          is_room_available = false
          break
        end
      end

      return is_room_available
    end

    def find_reservations_by_date(date)
      reserved_rooms = []
      start_date = date
      end_date = date
      date_to_find = Hotel::DateRange.new(start_date, end_date)

      # Iterate over all the keys (room_ids) in @reservations
      @reservations.each do |room_id, reservation|

        # Check if room has overlap for that day
        is_room_booked = !room_available?(room_id, date_to_find)

        # If there is overlap, add it to the list of rooms reserved
        if (is_room_booked)
          reserved_rooms.push(reservation)
        end
      end

      return reserved_rooms
    end

    def available_rooms(date_range)
      #Get the list of list of daterange (values of the hashmap) and iterate thru the list. When the date matches get the key(roomId) and store in local list. Return the list of rooms
      available_rooms = []
      @reservations.each_key do |room_id|
        @reservations[room_id].each do |room_range|

          # I can view a list of rooms that are not reserved for a given date range, so that I can see all available rooms for that day
          # I can reserve an available room for a given date range
          # I want an exception raised if I try to reserve a room that is unavailable for a given day, so that I cannot make two reservations for the same room that overlap by date

          if !date_range.overlap?
            available_rooms.push(room_id)
            break
          end
        end
      end
      return available_rooms
    end
  end
end
