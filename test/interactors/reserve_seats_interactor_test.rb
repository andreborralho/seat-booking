require 'test_helper'

class ReserveSeatsInteractorTest < ActiveSupport::TestCase
  test "should reserve selected seats" do
    session_id = "example_session_id"
    reservation = Reservation.create(session_id: session_id)
    seat1 = seats(:one)
    seat2 = seats(:two)
    seat1.update(status: Seat.statuses[:selected], reservation: reservation)
    seat2.update(status: Seat.statuses[:selected], reservation: reservation)

    interactor = ReserveSeatsInteractor.new(session_id)
    interactor.call
    seat1.reload
    seat2.reload

    #assert_equal Seat.statuses[:reserved], seat1.status
    #assert_equal Seat.statuses[:reserved], seat2.status
  end

  test "should not reserve seats with a different status" do
    session_id = "example_session_id"
    reservation = Reservation.create(session_id: session_id)
    seat1 = seats(:one)
    seat1.update(status: Seat.statuses[:free], reservation: reservation)

    interactor = ReserveSeatsInteractor.new(session_id)
    interactor.call
    seat1.reload

    assert_equal Seat.statuses[:free], seat1.status
  end
end
