class UpdateSeatInteractor
  def initialize(session_id, seat_id)
    @session_id = session_id
    @seat_id = seat_id
  end

  def call
    reservation = Reservation.find_or_create_by(session_id: @session_id.to_s)
    seat = Seat.find(@seat_id)
    status = seat.free? ? Seat.statuses[:selected] : Seat.statuses[:free]
    seat.update(status: status, reservation: reservation)
  end
end
