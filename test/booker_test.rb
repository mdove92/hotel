require_relative "test_helper"
require "date"

describe "Booker class" do
  describe "initialize" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)
    end
    it "gets initialized as a type of Booker" do
      expect @book.must_be_kind_of Hotel::Booker
    end
    it "creates an array of 20 hotel Ids" do
      expect @book.room_list.length.must_equal 20
      expect @book.room_list[2].must_be_kind_of Integer
      expect @book.room_list[2].must_equal 3
    end
  end

  describe "select_room" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)

      @test_start = "2019/12/25"
      @test_end = "2019/12/28"
      @test_range = Hotel::DateRange.new(@test_start, @test_end)
    end
    it "takes a daterange and returns a selected room number" do
      reservation = @book.select_room(@test_range)
      expect(reservation).must_be_kind_of Integer
    end
  end
  describe "make_reservation" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)

      @test_start = "2019/12/25"
      @test_end = "2019/12/28"
      @test_range = Hotel::DateRange.new(@test_start, @test_end)
    end
    it "takes a start_date and end_date and returns a reservation_id" do
      reservation = @book.make_reservation(@test_start, @test_end)
      expect(reservation.room_id).must_be_kind_of Integer
      # expect(reservation).must_be :<= 20

    end
  end

  describe "find_reservations_by_date" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)

      @test_start = "2019/12/25"
      @test_end = "2019/12/28"
      @test_range = Hotel::DateRange.new(@test_start, @test_end)
      @book.make_reservation(@test_start, @test_end)
    end

    it "takes a Date and returns an array of Reservations" do
      reservation_list = @book.find_reservations_by_date(@test_start)
      expect(reservation_list).must_be_kind_of Array
      reservation_list.each do |reservation|
        reservation.must_be_kind_of Hotel::Reservation
      end
    end

    it "returns a reservation for the date requested" do
      test_date = "2019/12/26"
      found_reservation = @book.find_reservations_by_date(test_date)
      expect found_reservation.length.must_equal 1
      expect found_reservation[0].room_id.must_equal 1
    end
  end

  describe "wave 2" do
    describe "room_available?" do
      before do
        @book = Hotel::Booker.new(number_of_rooms: 20)

        @test_start = "2019/12/25"
        @test_end = "2019/12/28"
        @test_range = Hotel::DateRange.new(@test_start, @test_end)
        @book.make_reservation(@test_start, @test_end)
      end
      it "returns true if given date does not overlap with any reservations for a given room_id" do
        test_date = "2019/12/15"
        search_range = Hotel::DateRange.new(test_date, test_date)
        expect @book.room_available?(1, search_range).must_equal true
      end
      it "returns false if given date does overlap with any reservations for given room_id" do
        test_date = "2019/12/26"
        search_range = Hotel::DateRange.new(test_date, test_date)
        expect @book.room_available?(1, search_range).must_equal false
      end
    end

    describe "available_rooms" do
      before do
        @book = Hotel::Booker.new(number_of_rooms: 20)

        @test_start = "2019/12/25"
        @test_end = "2019/12/28"
        @test_range = Hotel::DateRange.new(@test_start, @test_end)
        @book.make_reservation(@test_start, @test_end)
      end
      it "takes a date and returns a list" do
        available_rooms = @book.available_rooms(@test_range)
        expect(available_rooms).must_be_kind_of Array
        expect(available_rooms.length).must_equal 19

        @test_start = "2019/12/29"
        @test_end = "2019/12/30"
        @test_range = Hotel::DateRange.new(@test_start, @test_end)
        available_rooms = @book.available_rooms(@test_range)
        expect(available_rooms.length).must_equal 20
      end
    end

    describe "remove_reservation" do
      before do
        @book = Hotel::Booker.new(number_of_rooms: 20)

        @test_start = "2019/12/25"
        @test_end = "2019/12/28"
        @reservation = @book.make_reservation(@test_start, @test_end)
      end
      it "removes a reservation for the room" do
        test_date = "2019/12/26"
        found_reservation = @book.find_reservations_by_date(test_date)
        expect found_reservation.length.must_equal 1
        expect found_reservation[0].room_id.must_equal 1

        @book.remove_reservation(found_reservation[0])
        found_reservation = @book.find_reservations_by_date(test_date)
        expect found_reservation.length.must_equal 0
      end
    end

    describe "block reservations" do
      before do
        @book = Hotel::Booker.new(number_of_rooms: 20)

        @test_start = "2019/12/22"
        @test_end = "2019/12/26"
        @block_start = "2019/12/25"
        @block_end = "2019/12/28"
        @test_range = Hotel::DateRange.new(@test_start, @test_end)
        @block_range = Hotel::DateRange.new(@block_start, @block_end)
      end
      it "books a block or rooms" do
        rooms = [1, 2, 3, 4, 5]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        @book.book_block(block)

        expect @book.available_rooms(@block_range).length == 15
        reservations = @book.find_reservations_by_date("2019/12/25")
        expect reservations.length == 5
        room_ids = reservations.map { |res| res.room_id }
        expect room_ids.must_equal [1, 2, 3, 4, 5]
      end
      it "has a different price than an individually booked room" do
        rooms = [1, 2, 3, 4, 5]
        room = 7
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        reservations = @book.book_block(block)

        single_reservation = @book.create_reservation_for_room(room, @block_range)
        expect reservations[0].cost.must_be :<, single_reservation.cost
      end
      it "doesn't allow booking rooms in a reserved block" do
        rooms = [1, 2, 3, 4, 5]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        reservations = @book.book_block(block)

        expect { @book.create_reservation_for_room(1, @block_range) }.must_raise ArgumentError
      end
      it "lists available rooms from a block" do
        rooms = [1, 2, 3, 4, 5]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        reservations = @book.create_reservation_for_room(1, @block_range)
        available_rooms = @book.get_rooms_available_from_block(block)
        expect available_rooms.length == 4
      end
      it "allows booking a room from a block" do
        rooms = [1, 2, 3, 4, 5]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        reservation = @book.reserve_room_from_block(1, block)
        expect reservation.cost == rate * 3
        expect reservation.date_range == @block_range
      end
      it "raises an argument error when date in date range is reserved" do
        rooms = [1, 2, 3, 4, 5]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)
        reservation = @book.reserve_room_from_block(1, block)
        expect { @book.book_block(block) }.must_raise ArgumentError
      end
      it "raises an argument error there are more than 5 rooms in a reserved block" do
        rooms = [1, 2, 3, 4, 5, 6]
        rate = 130
        block = Hotel::Block.new(@block_range, rooms, rate)

        expect { @book.book_block(block) }.must_raise ArgumentError
      end
    end
  end
end
