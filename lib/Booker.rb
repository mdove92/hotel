

module Hotel
  class Booker
    attr_reader :rooms
    attr_accessor :reservations, :room_list

    def initialize(number_of_rooms: 20)

      # Hash reservation id to reservation
      @reservations_history = {}

      @current_reservation_id = 0

      # Hash of room id to an array of date_ranges
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
          break
        end
      end

      return available_room
    end

    def make_reservation(start_date, end_date)
      date_range = Hotel::DateRange.new(start_date, end_date)
      room_id = select_room(date_range)
      if (room_id != 0)
        room_booked = create_reservation_for_room(room_id, date_range)
      end
      return room_booked
    end

    def create_reservation_for_room(room_id, date_range, rate = 200)
      if (room_available?(room_id, date_range))
        room_booked = Hotel::Reservation.new(date_range, room_id, rate)
        @reservations[room_id].push(room_booked)
        @reservations_history[@current_reservation_id += 1] = room_booked
        return room_booked
      else
        throw ArgumentError.new("Room is unavailable for that date range")
      end
    end

    def remove_reservation(reservation)
      #Removes the given date_range from the list for the given room
      if (@reservations.key?(reservation.room_id))
        @reservations[reservation.room_id].delete(reservation)
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
      date_to_find.end_date += 1
      # Iterate over all the keys (room_ids) in @reservations
      @reservations_history.each_value do |reservation|

        # Check if room has overlap for that day
        is_room_booked = !room_available?(reservation.room_id, date_to_find)

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
        if (@reservations[room_id].length == 0)
          available_rooms.push(room_id)
        else
          @reservations[room_id].each do |room_range|
            if !date_range.overlaps?(room_range.date_range)
              available_rooms.push(room_id)
              break
            end
          end
        end
      end
      return available_rooms
    end

    def book_block(block)
      reservations = []
      if (block.rooms.length > 5)
        throw ArgumentError.new("More than 5 rooms in block")
      end

      block.rooms.each do |room|
        if (!room_available?(room, block.date_range))
          raise ArgumentError.new("Date range is unavailable")
        end
      end

      block.rooms.each do |room|
        block_reservation = create_reservation_for_room(room, block.date_range, block.discounted_cost)
        reservations.push(block_reservation)
      end

      return reservations
    end

    def get_rooms_available_from_block(block)
      available_rooms = []

      block.rooms.each do |room|
        if (room_available?(room, block.date_range))
          available_rooms.push(room)
        end
      end

      return available_rooms
    end

    def reserve_room_from_block(room_id, block)
      return create_reservation_for_room(room_id, block.date_range, block.discounted_cost)
    end
  end
end
