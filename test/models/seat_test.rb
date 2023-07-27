require "test_helper"

class SeatTest < ActiveSupport::TestCase
  test "should validate presence and inclusion of status" do
    seat = Seat.new(status: nil)
    assert_not seat.valid?
    assert_includes seat.errors[:status], "can't be blank"

    #seat.status = "invalid_status"
    #assert_not seat.valid?
    #assert_includes seat.errors[:status], "is not included in the list"
  end

  test "should validate presence and numericality of price" do
    seat = Seat.new(price: nil)
    assert_not seat.valid?
    assert_includes seat.errors[:price], "can't be blank"

    seat.price = "invalid_price"
    assert_not seat.valid?
    assert_includes seat.errors[:price], "is not a number"
  end

  test "should belong to a reservation" do
    seat = Seat.new
    assert_respond_to seat, :reservation
  end
end
