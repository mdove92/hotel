require_relative "test_helper"

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

  before do
    @booker = Hotel::Booker.new(number_of_rooms: 20)
  end
  describe "wave 1" do
    describe "rooms" do
      it "returns a list" do
        rooms = @booker.room_list
        expect(rooms).must_be_kind_of Array
      end
    end
    xdescribe "reserve_room" do
      it "takes two Date objects and returns a Reservation" do
        start_date = @date
        end_date = start_date + 3

        reservation = @hotel_controller.reserve_room(start_date, end_date)

        expect(reservation).must_be_kind_of Hotel::Reservation
      end
    end

    xdescribe "reservations" do
      it "takes a Date and returns a list of Reservations" do
        reservation_list = @hotel_controller.reservations(@date)

        expect(reservation_list).must_be_kind_of Array
        reservation_list.each do |res|
          res.must_be_kind_of Reservation
        end
      end
    end
  end

  xdescribe "wave 2" do
    describe "available_rooms" do
      it "takes two dates and returns a list" do
        start_date = @date
        end_date = start_date + 3

        room_list = @hotel_controller.available_rooms(start_date, end_date)

        expect(room_list).must_be_kind_of Array
      end
    end
  end
end
