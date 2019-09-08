require_relative "test_helper"
require "date"

describe "Booker class" do
  describe "initialize" do
    before do
      @book = Hotel::Booker.new(number_of_rooms: 20)
    end
    it "get initialized as a type of Booker" do
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
      reservation_list.each do |room_id, reservation|
        reservation.must_be_kind_of Reservation
      end
    end

    it "returns a reservation for the date requested" do
      test_date = "2019/12/26"
      found_reservation = @book.find_reservations_by_date(test_date)
      expect found_reservation.length.must_equal 1
      expect found_reservation[0].must_equal 1
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
        expect found_reservation[0].must_equal 1

        @book.remove_reservation(found_reservation[0], @reservation)
        found_reservation = @book.find_reservations_by_date(test_date)
        expect found_reservation.length.must_equal 0
      end
    end
  end
end
