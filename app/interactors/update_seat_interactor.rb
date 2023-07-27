class UpdateSeatInteractor
  def initialize(session_id, seat_id)
    @session_id = session_id
    @seat_id = seat_id
  end

  def call
    reservation = Reservation.find_or_create_by(session_id: @session_id.to_s)
    seat = Seat.find(@seat_id)
    status = seat.free? ? Seat.statuses[:selected] : Seat.statuses[:free]

    if seat.update(status: status, reservation: reservation)
      { success: true, seat: seat }
    else
      { success: false, errors: "Failed to reserve seats." }
    end
  end
end
