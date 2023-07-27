require "test_helper"

class ReservationTest < ActiveSupport::TestCase

  test "should have many seats" do
    reservation = Reservation.new
    assert_respond_to reservation, :seats
  end

  test "should validate presence of session_id" do
    reservation = Reservation.new(session_id: nil)
    assert_not reservation.valid?
    assert_includes reservation.errors[:session_id], "can't be blank"
  end
end
