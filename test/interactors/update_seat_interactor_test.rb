require 'test_helper'

class UpdateSeatInteractorTest < ActiveSupport::TestCase
  test "should update seat status and reservation" do
    session_id = "example_session_id"
    reservation = Reservation.create(session_id: session_id)
    seat1 = seats(:one)
    seat1.update(status: Seat.statuses[:free], reservation: reservation)

    interactor = UpdateSeatInteractor.new(session_id, seat1.id)
    interactor.call
    seat1.reload

    #assert_equal Seat.statuses[:selected], seat1.status
    #assert_equal reservation, seat1.reservation
  end

  test "should toggle seat status and reservation" do
    session_id = "example_session_id"
    reservation = Reservation.create(session_id: session_id)
    seat1 = seats(:one)
    seat1.update(status: Seat.statuses[:selected], reservation: reservation)

    interactor = UpdateSeatInteractor.new(session_id, seat1.id)
    interactor.call
    seat1.reload

    assert_equal Seat.statuses[:free], seat1.status
    assert_nil seat1.reservation
  end
end
