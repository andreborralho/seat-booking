require 'test_helper'

class LoadSeatsInteractorTest < ActiveSupport::TestCase
  fixtures :seats

  test "should load seats and return the expected result" do
    session_id = "example_session_id"
    reservation = Reservation.create(session_id: session_id)

    seat1 = seats(:one)
    seat2 = seats(:two)
    seat1.update(reservation: reservation, status: Seat.statuses[:selected])
    seat2.update(reservation: reservation, status: Seat.statuses[:selected])

    interactor = LoadSeatsInteractor.new(session_id)
    result = interactor.call

    assert_equal [seat1, seat2], result[:all]
    #assert_equal seat2.positionX + 1, result[:maxX]
    #assert_equal seat2.positionY + 1, result[:maxY]
    assert_equal reservation, result[:reservation]
  end
end
