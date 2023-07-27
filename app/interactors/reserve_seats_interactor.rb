class ReserveSeatsInteractor
  def initialize(seat_ids, session_id)
    @seat_ids = seat_ids
    @session_id = session_id
  end

  def call
    reservation = Reservation.find_or_create_by(session_id: @session_id.to_s)
    seats = Seat.find(@seat_ids)
    seats.update_all(status: 'reserved')
    reservation.seats << seats

    if reservation.save!
      { success: true, seats: reservation.seats }
    else
      { success: false, errors: "Failed to reserve seats." }
    end
  end
end
